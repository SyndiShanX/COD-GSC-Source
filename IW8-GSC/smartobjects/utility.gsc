/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: smartobjects\utility.gsc
***********************************************/

init_smartobjects() {
  if(isDefined(anim.smartobjects)) {
    return;
  }
  anim.smartobjects = [];
}

validate() {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }
  foreach(var_1 in anim.smartobjectpoints) {}
}

add_smartobject_type(var_0, var_1, var_2) {
  init_smartobjects();
  var_3 = spawnStruct();
  var_3.fngetinfo = var_1;
  var_3.fnusecondition = var_2;
  anim.smartobjects[var_0] = var_3;
}

createsmartobjectinfo() {
  var_0 = spawnStruct();
  var_0.animlist = [];
  return var_0;
}

addsmartobjectanim_internal(var_0, var_1) {
  if(!isDefined(self.animlist[var_0]))
    self.animlist[var_0] = [];

  self.animlist[var_0] = var_1;
}

addsmartobjectintroanim(var_0) {
  addsmartobjectanim_internal("_encstr_873612FA8828525BA0D5A3973FD511B1B8333245", var_0);
  self.hasintro = 1;
}

addsmartobjectanim(var_0) {
  addsmartobjectanim_internal("_encstr_ACFD124B10BBEAA380560A3DFECB4735FF2892C2", var_0);
}

addsmartobjectreactanim(var_0) {
  if(isDefined(var_0))
    addsmartobjectanim_internal("_encstr_AABF12C8820EBDD3DF0A5AC5E35B7E45F7AAD078", var_0);

  self.hasreact = 1;
}

addsmartobjectoutroanim(var_0) {
  addsmartobjectanim_internal("_encstr_887B12CDB6C2C9A3B7134D5636D1BEBDAB474E7B", var_0);
  self.hasoutro = 1;
}

addsmartobjectarrivalanims() {
  self.hasarrivals = 1;
}

addsmartobjectexitanims() {
  self.hasexits = 1;
}

addsmartobjectpainanim(var_0) {
  if(isDefined(var_0))
    addsmartobjectanim_internal("_encstr_A95811DC6B854E1D7B26A9568DE8D7830BB49B", var_0);

  self.haspain = 1;
}

addsmartobjectdeathanim(var_0) {
  if(isDefined(var_0))
    addsmartobjectanim_internal("_encstr_B413120842CE7D131FCA9A05A31B3E29B7EAA858", var_0);

  self.hasdeath = 1;
}

getsmartobjecttype(var_0) {
  return anim.smartobjects[var_0];
}

smartobject_setnextuse() {
  var_0 = getsmartobjecttype(self.script_smartobject);
  var_1 = self[[var_0.fngetinfo]]();

  if(isDefined(var_1.useonce)) {
    self.neveruseagain = 1;
    return;
  }

  var_2 = gettime() + var_1.nextusetime * 1000;
  self.nextusetime = var_2;

  if(isDefined(self.linkedsmartobjects)) {
    foreach(var_4 in self.linkedsmartobjects) {
      if(isDefined(var_4.nextusetime)) {
        var_4.nextusetime = max(var_4.nextusetime, var_2);
        continue;
      }

      var_4.nextusetime = var_2;
    }
  }
}

claimsmartobject(var_0) {
  var_0.claimer = self;
}

unclaimsmartobject(var_0) {
  var_0.claimer = undefined;
}

canclaimsmartobject(var_0) {
  return !isDefined(var_0.claimer);
}

canusesmartobject(var_0) {
  if(istrue(var_0.donotuse))
    return 0;

  if(isDefined(var_0.neveruseagain))
    return 0;

  if(isDefined(var_0.nextusetime) && gettime() < var_0.nextusetime)
    return 0;

  var_1 = getsmartobjecttype(var_0.script_smartobject);
  var_2 = [[var_1.fnusecondition]](var_0);
  return var_2;
}

getbestsmartobject(var_0, var_1, var_2) {
  if(!isDefined(anim.smartobjectpoints))
    return undefined;

  var_3 = var_2 * var_2;
  var_4 = sortbydistance(anim.smartobjectpoints, var_0);
  var_5 = var_4.size;

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = var_4[var_6];

    if(distancesquared(var_7.origin, var_0) > var_3) {
      break;
    }

    if(!canclaimsmartobject(var_7)) {
      continue;
    }
    if(!canusesmartobject(var_7)) {
      continue;
    }
    if(!issmartobjectwithinrange(var_7, var_0, var_1)) {
      continue;
    }
    var_8 = getsmartobjecttype(var_7.script_smartobject);

    if([[var_8.fnusecondition]](var_7))
      return var_7;
  }

  return undefined;
}

isplayernearsmartobject(var_0) {
  var_1 = 1600;
  var_2 = 4096;

  foreach(var_4 in level.players) {
    if(distance2dsquared(var_0.origin, var_4.origin) < var_1 && squared(var_0.origin[2] - var_4.origin[2]) < var_2) {
      var_5 = vectortoyaw(var_4.origin - var_0.origin);

      if(abs(angleclamp180(var_5 - var_0.angles[1])) < 90)
        return 1;
    }
  }

  return 0;
}

getbestsmartobjectalongline(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }
  var_7 = 60;
  var_8 = 60;
  var_9 = 5184;
  var_10 = 48;

  if(isDefined(var_2.volume.script_radius))
    var_10 = var_2.volume.script_radius;

  var_11 = 128;

  if(isDefined(var_2.volume.script_maxdist))
    var_11 = var_2.volume.script_maxdist;

  var_12 = var_1 - var_0;
  var_13 = length(var_12);
  var_14 = var_12 / var_13;
  var_15 = vectorNormalize((var_14[1], -1 * var_14[0], 0));
  var_16 = 0;
  var_17 = undefined;
  var_18 = 60;
  var_19 = 5;
  var_20 = 0.33;
  var_21 = 1.5;
  var_22 = 300000;
  var_23 = 0.001;
  var_24 = undefined;
  var_25 = -9999;

  foreach(var_27 in var_2.smart_objects) {
    if(distancesquared(var_27.origin, self.origin) < var_9) {
      continue;
    }
    if(!canclaimsmartobject(var_27)) {
      continue;
    }
    if(!istrue(var_6) && !canusesmartobject(var_27)) {
      continue;
    }
    var_28 = var_27.origin - var_0;
    var_29 = vectordot(var_14, var_28);

    if(var_29 < var_4) {
      continue;
    }
    if(var_29 > var_13 + var_7) {
      continue;
    }
    var_30 = abs(vectordot(var_15, var_28));
    var_31 = getsmartobjectradiussq(var_27);

    if(var_30 * var_30 > var_31) {
      continue;
    }
    var_32 = var_11;

    if(var_13 - var_30 < 60)
      var_32 = var_32 * 0.5;

    if(var_30 > var_32) {
      continue;
    }
    if(isDefined(var_3) && !ispointinvolume(var_27.origin, var_3)) {
      continue;
    }
    var_33 = getsmartobjecttype(var_27.script_smartobject);
    var_34 = var_13 - var_4;
    var_35 = var_29 - var_4;
    var_36 = var_5 - var_4;

    if(var_35 < var_36)
      var_37 = var_19 + var_18 * (1 - (var_36 - var_35) / var_36);
    else {
      var_34 = var_13 - var_5 + var_7;
      var_35 = var_29 - var_5;
      var_37 = var_19 + var_18 * (var_34 - var_35) / var_34;
    }

    if(var_30 > var_10) {
      var_38 = var_30 - var_10;
      var_37 = var_37 * (var_20 + (1 - var_38 / (var_32 - var_10)) * (1 - var_20));
    }

    if(isplayernearsmartobject(var_27))
      var_37 = var_37 * var_21;

    var_39 = var_27[[var_33.fngetinfo]]();

    if(isDefined(var_39.fngetprioritymultiplier))
      var_37 = var_37 * self[[var_39.fngetprioritymultiplier]](var_27);

    if(isDefined(var_27.lastusetime)) {
      if(gettime() - var_27.lastusetime < var_22)
        var_37 = var_37 * var_23;
      else
        var_27.lastusetime = undefined;
    }

    if(var_37 > var_25) {
      var_25 = var_37;
      var_24 = var_27;
    }
  }

  return var_24;
}

getsmartobjectradiussq(var_0) {
  if(isDefined(var_0.radius))
    return var_0.radius * var_0.radius;

  var_1 = anim.smartobjects[var_0.script_smartobject];
  var_2 = [[var_1.fngetinfo]]();

  if(isDefined(var_2.radius))
    return var_2.radius * var_2.radius;

  return var_2.radiussqrd;
}

issmartobjectwithinrange(var_0, var_1, var_2) {
  if(isDefined(var_1))
    var_3 = var_1;
  else
    var_3 = self.origin;

  var_4 = distancesquared(var_3, var_0.origin);

  if(isDefined(var_0.radius)) {
    if(var_4 > squared(var_0.radius))
      return 0;
  } else {
    var_5 = anim.smartobjects[var_0.script_smartobject];
    var_6 = [[var_5.fngetinfo]]();

    if(var_4 > var_6.radiussqrd)
      return 0;
  }

  if(isDefined(var_2) && !ispointinvolume(var_0.origin, var_2))
    return 0;

  return 1;
}

setcustomsmartobjectarrivaldata(var_0) {
  var_1 = getsmartobjecttype(var_0.script_smartobject);
  var_2 = [[var_1.fngetinfo]]();

  if(!istrue(var_2.hasarrivals)) {
    return;
  }
  self.asm.customdata.arrivalangles = var_0.angles;
  self.asm.customdata.arrivalstate = var_2.animstatename;
  self.asm.customdata.arrivalusefootdown = 1;
  self.asm.customdata.arrivaloptionalprefix = "_encstr_964608EA62DD1803193A";
}

setsmartobject(var_0) {
  var_1 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(isDefined(var_1))
    clearsmartobject(var_1);

  claimsmartobject(var_0);
  scripts\asm\asm_bb::bb_requestsmartobject(var_0);
}

clearsmartobject(var_0) {
  if(isDefined(var_0))
    unclaimsmartobject(var_0);

  scripts\asm\asm_bb::bb_clearsmartobject();
}

canusesmartobject_stealth(var_0) {
  if(!isDefined(self.script_stealthgroup))
    return 0;

  if(![[self.fnisinstealthinvestigate]]() && ![[self.fnisinstealthhunt]]())
    return 0;

  if(isDefined(self.enemy))
    return 0;

  return 1;
}

canusesmartobject_nostrafenoturn(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = vectorNormalize(var_0.origin - self.origin);

  if(vectordot(var_1, var_2) >= cos(60))
    var_3 = 64;
  else
    var_3 = 100;

  if(distancesquared(self.origin, var_0.origin) <= var_3 * var_3)
    return 0;

  var_1 = anglesToForward(var_0.angles);

  if(vectordot(var_1, var_2) < cos(45))
    return 0;

  return 1;
}