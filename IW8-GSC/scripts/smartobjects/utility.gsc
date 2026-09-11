/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\smartobjects\utility.gsc
***********************************************/

function init_smartobjects() {
  if(isDefined(anim.smartobjects)) {
    return;
  }

  anim.smartobjects = [];
}

function validate() {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }

  foreach(var1 in anim.smartobjectpoints) {}
}

function add_smartobject_type(var0, var1, var2) {
  init_smartobjects();
  var3 = spawnStruct();
  var3.fngetinfo = var1;
  var3.fnusecondition = var2;
  anim.smartobjects[var0] = var3;
}

function createsmartobjectinfo() {
  var0 = spawnStruct();
  var0.animlist = [];
  return var0;
}

function addsmartobjectanim_internal(var0, var1) {
  if(!isDefined(self.animlist[var0])) {
    self.animlist[var0] = [];
  }

  self.animlist[var0] = var1;
}

function addsmartobjectintroanim(var0) {
  addsmartobjectanim_internal("smartobject_intro", var0);
  self.hasintro = 1;
}

function addsmartobjectanim(var0) {
  addsmartobjectanim_internal("smartobject_logic", var0);
}

function addsmartobjectreactanim(var0) {
  if(isDefined(var0)) {
    addsmartobjectanim_internal("smartobject_react", var0);
  }

  self.hasreact = 1;
}

function addsmartobjectoutroanim(var0) {
  addsmartobjectanim_internal("smartobject_outro", var0);
  self.hasoutro = 1;
}

function addsmartobjectarrivalanims() {
  self.hasarrivals = 1;
}

function addsmartobjectexitanims() {
  self.hasexits = 1;
}

function addsmartobjectpainanim(var0) {
  if(isDefined(var0)) {
    addsmartobjectanim_internal("smartobject_pain", var0);
  }

  self.haspain = 1;
}

function addsmartobjectdeathanim(var0) {
  if(isDefined(var0)) {
    addsmartobjectanim_internal("smartobject_death", var0);
  }

  self.hasdeath = 1;
}

function getsmartobjecttype(var0) {
  return anim.smartobjects[var0];
}

function smartobject_setnextuse() {
  var0 = getsmartobjecttype(self.script_smartobject);
  var1 = self[[var0.fngetinfo]]();

  if(isDefined(var1.useonce)) {
    self.neveruseagain = 1;
    return;
  }

  var2 = gettime() + var1.nextusetime * 1000;
  self.nextusetime = var2;

  if(isDefined(self.linkedsmartobjects)) {
    foreach(var4 in self.linkedsmartobjects) {
      if(isDefined(var4.nextusetime)) {
        var4.nextusetime = max(var4.nextusetime, var2);
        continue;
      }

      var4.nextusetime = var2;
    }

    return;
  }
}

function claimsmartobject(var0) {
  var0.claimer = self;
}

function unclaimsmartobject(var0) {
  var0.claimer = undefined;
}

function canclaimsmartobject(var0) {
  return !isDefined(var0.claimer);
}

function canusesmartobject(var0) {
  if(istrue(var0.donotuse)) {
    return 0;
  }

  if(isDefined(var0.neveruseagain)) {
    return 0;
  }

  if(isDefined(var0.nextusetime) && gettime() < var0.nextusetime) {
    return 0;
  }

  var1 = getsmartobjecttype(var0.script_smartobject);
  var2 = [[var1.fnusecondition]](var0);
  return var2;
}

function getbestsmartobject(var0, var1, var2) {
  if(!isDefined(anim.smartobjectpoints)) {
    return undefined;
  }

  var3 = var2 * var2;
  var4 = sortbydistance(anim.smartobjectpoints, var0);
  var5 = var4.size;

  for(var6 = 0; var6 < var5; var6++) {
    var7 = var4[var6];

    if(distancesquared(var7.origin, var0) > var3) {
      break;
    }

    if(!canclaimsmartobject(var7)) {
      continue;
    }

    if(!canusesmartobject(var7)) {
      continue;
    }

    if(!issmartobjectwithinrange(var7, var0, var1)) {
      continue;
    }

    var8 = getsmartobjecttype(var7.script_smartobject);

    if([[var8.fnusecondition]](var7)) {
      return var7;
    }
  }

  return undefined;
}

function isplayernearsmartobject(var0) {
  var1 = 1600;
  var2 = 4096;

  foreach(var4 in level.players) {
    if(distance2dsquared(var0.origin, var4.origin) < var1 && squared(var0.origin[2] - var4.origin[2]) < var2) {
      var5 = vectortoyaw(var4.origin - var0.origin);

      if(abs(angleclamp180(var5 - var0.angles[1])) < 90) {
        return true;
      }
    }
  }

  return false;
}

function getbestsmartobjectalongline(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }

  var7 = 60;
  var8 = 60;
  var9 = 5184;
  var10 = 48;

  if(isDefined(var2.volume.script_radius)) {
    var10 = var2.volume.script_radius;
  }

  var11 = 128;

  if(isDefined(var2.volume.script_maxdist)) {
    var11 = var2.volume.script_maxdist;
  }

  var12 = var1 - var0;
  var13 = length(var12);
  var14 = var12 / var13;
  var15 = vectorNormalize((var14[1], -1 * var14[0], 0));
  var16 = 0;
  var17 = undefined;
  var18 = 60;
  var19 = 5;
  var20 = 0.33;
  var21 = 1.5;
  var22 = 300000;
  var23 = 0.001;
  var24 = undefined;
  var25 = -9999;

  foreach(var27 in var2.smart_objects) {
    if(distancesquared(var27.origin, self.origin) < var9) {
      continue;
    }

    if(!canclaimsmartobject(var27)) {
      continue;
    }

    if(!istrue(var6) && !canusesmartobject(var27)) {
      continue;
    }

    var28 = var27.origin - var0;
    var29 = vectordot(var14, var28);

    if(var29 < var4) {
      continue;
    }

    if(var29 > var13 + var7) {
      continue;
    }

    var30 = abs(vectordot(var15, var28));
    var31 = getsmartobjectradiussq(var27);

    if(var30 * var30 > var31) {
      continue;
    }

    var32 = var11;

    if(var13 - var30 < 60) {
      var32 *= 0.5;
    }

    if(var30 > var32) {
      continue;
    }

    if(isDefined(var3) && !ispointinvolume(var27.origin, var3)) {
      continue;
    }

    var33 = getsmartobjecttype(var27.script_smartobject);
    var34 = var13 - var4;
    var35 = var29 - var4;
    var36 = var5 - var4;

    if(var35 < var36) {
      var37 = var19 + var18 * (1 - (var36 - var35) / var36);
    } else {
      var34 = var13 - var5 + var7;
      var35 = var29 - var5;
      var37 = var19 + var18 * (var34 - var35) / var34;
    }

    if(var30 > var10) {
      var38 = var30 - var10;
      var37 *= var20 + (1 - var38 / (var32 - var10)) * (1 - var20);
    }

    if(isplayernearsmartobject(var27)) {
      var37 *= var21;
    }

    var39 = var27[[var33.fngetinfo]]();

    if(isDefined(var39.fngetprioritymultiplier)) {
      var37 *= self[[var39.fngetprioritymultiplier]](var27);
    }

    if(isDefined(var27.lastusetime)) {
      if(gettime() - var27.lastusetime < var22) {
        var37 *= var23;
      } else {
        var27.lastusetime = undefined;
      }
    }

    if(var37 > var25) {
      var25 = var37;
      var24 = var27;
    }
  }

  return var24;
}

function getsmartobjectradiussq(var0) {
  if(isDefined(var0.radius)) {
    return (var0.radius * var0.radius);
  }

  var1 = anim.smartobjects[var0.script_smartobject];
  var2 = [[var1.fngetinfo]]();

  if(isDefined(var2.radius)) {
    return (var2.radius * var2.radius);
  }

  return var2.radiussqrd;
}

function issmartobjectwithinrange(var0, var1, var2) {
  if(isDefined(var1)) {
    var3 = var1;
  } else {
    var3 = self.origin;
  }

  var4 = distancesquared(var3, var1.origin);

  if(isDefined(var1.radius)) {
    if(var4 > squared(var1.radius)) {
      return false;
    }
  } else {
    var5 = anim.smartobjects[var1.script_smartobject];
    var6 = [[var5.fngetinfo]]();

    if(var4 > var6.radiussqrd) {
      return false;
    }
  }

  if(isDefined(var3) && !ispointinvolume(var1.origin, var3)) {
    return false;
  }

  return true;
}

function setcustomsmartobjectarrivaldata(var0) {
  var1 = getsmartobjecttype(var0.script_smartobject);
  var2 = [[var1.fngetinfo]]();

  if(!istrue(var2.hasarrivals)) {
    return;
  }

  self.asm.customdata.arrivalangles = var0.angles;
  self.asm.customdata.arrivalstate = var2.animstatename;
  self.asm.customdata.arrivalusefootdown = 1;
  self.asm.customdata.arrivaloptionalprefix = "arrival";
}

function setsmartobject(var0) {
  var1 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(isDefined(var1)) {
    clearsmartobject(var1);
  }

  claimsmartobject(var0);
  scripts\asm\asm_bb::bb_requestsmartobject(var0);
}

function clearsmartobject(var0) {
  if(isDefined(var0)) {
    unclaimsmartobject(var0);
  }

  scripts\asm\asm_bb::bb_clearsmartobject();
}

function canusesmartobject_stealth(var0) {
  if(!isDefined(self.script_stealthgroup)) {
    return false;
  }

  if(![[self.fnisinstealthinvestigate]]() && ![[self.fnisinstealthhunt]]()) {
    return false;
  }

  if(isDefined(self.enemy)) {
    return false;
  }

  return true;
}

function canusesmartobject_nostrafenoturn(var0) {
  var1 = anglesToForward(self.angles);
  var2 = vectorNormalize(var0.origin - self.origin);

  if(vectordot(var1, var2) >= cos(60)) {
    var3 = 64;
  } else {
    var3 = 100;
  }

  if(distancesquared(self.origin, var1.origin) <= var3 * var3) {
    return false;
  }

  var2 = anglesToForward(var1.angles);

  if(vectordot(var2, var3) < cos(45)) {
    return false;
  }

  return true;
}