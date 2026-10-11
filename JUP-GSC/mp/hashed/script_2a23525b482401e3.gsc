/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2a23525b482401e3.gsc
*************************************************/

#using script_53651341190c5aab;
#using scripts\asm\asm;
#using scripts\asm\cap;
#namespace solo_interaction;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_9edce9aa4f165c6b":
      return &startpatrolcap;
    case #"hash_fe0e9f8796a0acad":
      return &onuserinit;
    case #"hash_e93ace2ec1639636":
      return &onuserterminate;
    case #"hash_1bda0008592d217c":
      return &function_b8a54ef5dc160380;
    case #"hash_f67d8dffeaed2c04":
      return &function_d77b520cefcefa50;
    case #"hash_c3f922b3de94557b":
      return &filtershouldreact;
    case #"hash_9f9e07224ff2a95a":
      return &calcstartorigin;
    case #"hash_d4dd8779b1436104":
      return &filterincombat;
    case #"hash_6e88d76179a2a0c0":
      return &shouldexitloop;
    case #"hash_fd9154ff75bc4e6b":
      return &function_d8786f820807c4f;
    case #"hash_8cc77e3e31358f72":
      return &usecustomreact;
    case #"hash_96267c6c4ba82c4a":
      return &hasreactaliases;
  }

  return namespace_f901a4f9d899be59::function_efcea5d26798e5b6(funcid);
}

function onuserinit(interactionid) {
  self.var_509c25e93045428d = 0;
  self.customarrivalhandler = &startpatrolcap;
}

function onuserterminate(interactionid) {
  self.var_7916f201efb9963f = undefined;
  namespace_f901a4f9d899be59::ondeleteuser(interactionid);

  if(self.asmname != self.defaultasm && (filterincombat() || filtershouldreact())) {
    self._blackboard.bseqphase = "react";
  } else {
    self._blackboard.bseqphase = "end";
  }

  self notify("interaction_end");
}

function function_b8a54ef5dc160380(receiver, info, origin) {
  return false;
}

function startpatrolcap(statename, params) {
  role = "guy";

  if(issubstr(self.animsetname, "guard")) {
    role = "pistol";
  }

  capinfo = getcapinfoforrole(self, role);

  if(!isDefined(capinfo)) {
    role = "guy";
    capinfo = getcapinfoforrole(self, "guy");
  }

  namespace_f901a4f9d899be59::startcap(statename, [role]);
}

function calcstartorigin(statename, role) {
  capinfo = getcapinfoforrole(self, role);
  animset = capinfo.animation;
  arrivalstateoverride = capinfo.arrivalstateoverride;
  introstatename = capinfo.initialstate;
  introaliasname = capinfo.initialalias;
  id = self getinteractionid();
  assert(isDefined(id));
  origin = getinteractionorigin(id);
  angles = getinteractionangles(id);

  if(isDefined(introstatename) && isDefined(introaliasname)) {
    animid = archetypegetrandomalias(animset, introstatename, introaliasname, 0);
    assert(animid >= 0);
    xanim = animsetgetanimfromindex(animset, introstatename, animid);
    origin = getstartorigin(origin, angles, xanim);
  }

  if(isDefined(self._blackboard.idlenode) && istrue(self._blackboard.idlenode.script_faceangles)) {
    self.customarrivalangles = angles;
  }

  return origin;
}

function function_3c2bc94b2abf6fad(asmname, statename, params) {
  animid = asm_getanim(asmname, statename);
  xanim = asm_getxanim(statename, animid);

  if(isDefined(params) && params == "loop") {
    self.var_509c25e93045428d += getanimlength(xanim);
    cap_loopanim(asmname, statename, params);
    return;
  }

  function_fb8afeabd23a5ef5(asmname, statename, params, animid);
}

function filtershouldreact(params) {
  return isDefined(self.var_fd01ad49b4e38ae8);
}

function function_d8786f820807c4f(statename, params) {
  newstate = "custom_patrol_lookaround_passthrough";

  if(!isDefined(params[0])) {
    newstate = "stl_react_passthrough";

    if(!isDefined(self.var_fd01ad49b4e38ae8)) {
      if(isDefined(self.var_de7ab32958c52392)) {
        self.var_fd01ad49b4e38ae8 = self.var_de7ab32958c52392;
      } else {
        self.var_fd01ad49b4e38ae8 = "med";
      }
    }
  }

  if(self asmhasstate(self.asmname, newstate)) {
    assert(self asmhasstate(self.asmname, newstate));
    self asmsetstate(self.asmname, newstate);
  }
}

function filterincombat(statename, params) {
  return self.bisincombat || isDefined(self.stealth) && self.stealth_bsmstate != 0;
}

function function_a8367856a2c4316f() {
  if(!isDefined(self._blackboard.idlenode)) {
    return (self.var_509c25e93045428d * 1000 + gettime());
  }

  looptime = 0;

  if(isDefined(self._blackboard.idlenode.script_delay_min) && isDefined(self._blackboard.idlenode.script_delay_max)) {
    looptime = randomfloatrange(self._blackboard.idlenode.script_delay_min, self._blackboard.idlenode.script_delay_max);
  } else if(isDefined(self._blackboard.idlenode.script_delay)) {
    looptime = self._blackboard.idlenode.script_delay;
  }

  if(istrue(self._blackboard.idlenode.script_cleanexit)) {
    animtimes = int(looptime / self.var_509c25e93045428d);
    fraction = looptime - animtimes * self.var_509c25e93045428d;

    if(fraction > 0) {
      animtimes += 1;
    }

    looptime = animtimes * self.var_509c25e93045428d;
  }

  time = (self.var_509c25e93045428d + looptime) * 1000 + gettime();
  return time;
}

function shouldexitloop(asmname, statename, params) {
  if(isDefined(self._blackboard.idlenode) && isDefined(self._blackboard.idlenode.repeat_interaction)) {
    if(istrue(int(self._blackboard.idlenode.repeat_interaction))) {
      return 0;
    }
  }

  if(istrue(self.var_36023fdce648d2ea)) {
    return 0;
  }

  if(!isDefined(self.var_7916f201efb9963f) || self.var_7916f201efb9963f <= 0) {
    self.var_7916f201efb9963f = function_a8367856a2c4316f();
  }

  if(isDefined(self.var_7916f201efb9963f)) {
    remainingtime = self.var_7916f201efb9963f - gettime();

    return (remainingtime <= 0);
  }

  return 1;
}

function function_d77b520cefcefa50(statename, params) {
  return isDefined(self._blackboard.bseqphase) && self._blackboard.bseqphase == "looping";
}

function usecustomreact(param) {
  statename = "react";
  alias = function_6d173209b1c25616();
  animresult = archetypegetrandomalias(self.animsetname, statename, alias, 0);

  if(isDefined(animresult)) {
    return true;
  }

  return false;
}

function function_6d173209b1c25616() {
  reactyaw = 0;

  if(isDefined(self.var_1c9ed4a46d13edc9)) {
    delta = self.var_1c9ed4a46d13edc9 - self.origin;
    deltayaw = vectortoyaw(delta);
    reactyaw = self.angles[1] - deltayaw;
  }

  reactyaw = angleclamp180(reactyaw);
  directionindex = function_de2aa7eb339a432c(reactyaw);
  suffix = directionindex;

  if(reactyaw < -120 && reactyaw > -180) {
    suffix += "l";
  } else if(reactyaw > 120 && reactyaw < 180) {
    suffix += "r";
  }

  return suffix;
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

function hasreactaliases(asmname, statename, tostatename, params) {
  aliases = archetypegetaliases(self.animsetname, tostatename);
  return isDefined(aliases);
}