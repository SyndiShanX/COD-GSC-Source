/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\cqb.gsc
***********************************************/

function setupcqbpointsofinterest() {
  level.cqbpointsofinterest = [];
  level.fnfindcqbpointsofinterest = &findcqbpointsofinterest;
  thread gatherdynamiccqbstructs();
}

function gatherdynamiccqbstructs() {
  waittillframeend();
  var0 = "poi";
  var1 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var3 in var1) {
    level.cqbpointsofinterest[level.cqbpointsofinterest.size] = var3;
  }
}

function findcqbpointsofinterest() {
  if(isDefined(anim.findingcqbpointsofinterest)) {
    return;
  }

  anim.findingcqbpointsofinterest = 1;
  waitframe();

  for(;;) {
    var0 = level.poi_activeai;

    if(!isDefined(var0)) {
      waitframe();
      continue;
    }

    var1 = [];
    var2 = 0;

    foreach(var4 in var0) {
      if(isalive(var4)) {
        var4.cqb_point_of_interest = findbestpoi(var4);
        wait 0.05;
        var2 = 1;
        continue;
      }

      var1 = var4;
    }

    foreach(var4 in var1) {
      level.poi_activeai = scripts\engine\utility::array_remove(level.poi_activeai, var4);
    }

    if(!var2) {
      wait 0.25;
    }
  }
}

function findbestpoi() {
  var0 = 5000;
  var1 = isDefined(self.pathgoalpos);
  var2 = isDefined(self.currentpoi);

  if(!var2 && isDefined(self.poi_firstpoint)) {
    return findfirstpoiinlink();
  }

  if(var2 && isDefined(self.currentpoi.target) || isDefined(self.nextpoi)) {
    return findnextpoiinlink(var2);
  }
}

function findfirstpoiinlink() {
  if(sighttracepassed(self getEye(), self.poi_firstpoint.origin, 0, undefined)) {
    var0 = self.poi_firstpoint;

    if(isDefined(var0.target)) {
      self.nextpoi = scripts\engine\utility::getStruct(var0.target, "targetname");
    }

    if(iswithinfov(var0)) {
      return var0;
    }

    return undefined;
  }

  return undefined;
}

function findnextpoiinlink(var0) {
  var1 = undefined;

  if(var0) {
    if(isDefined(self.currentpoi.target)) {
      self.nextpoi = scripts\engine\utility::getStruct(self.currentpoi.target, "targetname");
    } else {
      self.nextpoi = undefined;
    }
  }

  if(isDefined(self.poi_firstpoint)) {
    self.poi_firstpoint = undefined;
  }

  if(var0 && isDefined(self.currentpoi.script_time_min)) {
    var1 = self.currentpoi.script_time_min * 1000;
  } else {
    var1 = 1200;
  }

  if(!isDefined(self.nextpoi)) {
    if(gettime() < self.poi_starttime + var1 && iswithinfov(self.currentpoi)) {
      return self.currentpoi;
    } else {
      scripts\common\ai::poi_enable(0);
      return undefined;
    }
  }

  if(var0 && gettime() < self.poi_starttime + var1 && iswithinfov(self.currentpoi)) {
    return self.currentpoi;
  }

  if(!sighttracepassed(self getEye(), self.nextpoi.origin, 0, undefined)) {
    return undefined;
  }

  if(!iswithinfov(self.nextpoi)) {
    if(isDefined(self.nextpoi.target)) {
      self.nextpoi = scripts\engine\utility::getStruct(self.nextpoi.target, "targetname");
    } else {
      scripts\common\ai::poi_enable(0);
    }

    return undefined;
  }

  return self.nextpoi;
}

function iswithinfov(var0) {
  if(istrue(self.poi_disablefov)) {
    return true;
  }

  var1 = anglesToForward(self.angles);
  var2 = acos(vectordot(var1, vectorNormalize(var0.origin - self getEye())));
  return var2 < scripts\engine\utility::ter_op(isDefined(self.poi_fovlimit), self.poi_fovlimit, 90);
}