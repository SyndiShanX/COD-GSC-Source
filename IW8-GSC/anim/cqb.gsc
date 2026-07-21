/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\cqb.gsc
***********************************************/

setupcqbpointsofinterest() {
  level.cqbpointsofinterest = [];
  level.fnfindcqbpointsofinterest = ::findcqbpointsofinterest;
  thread gatherdynamiccqbstructs();
}

gatherdynamiccqbstructs() {
  waittillframeend;
  var_0 = "_encstr_B8190438ED4B";
  var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  level.cqbpointsofinterest[level.cqbpointsofinterest.size] = var_3;
}

findcqbpointsofinterest() {
  if(isDefined(anim.findingcqbpointsofinterest)) {
    return;
  }
  anim.findingcqbpointsofinterest = 1;
  waitframe();

  for(;;) {
    var_0 = level.poi_activeai;

    if(!isDefined(var_0)) {
      waitframe();
      continue;
    }

    var_1 = [];
    var_2 = 0;

    foreach(var_4 in var_0) {
      if(isalive(var_4)) {
        var_4.cqb_point_of_interest = var_4 findbestpoi();
        wait 0.05;
        var_2 = 1;
        continue;
      }

      var_1[var_1.size] = var_4;
    }

    foreach(var_4 in var_1)
    level.poi_activeai = scripts\engine\utility::array_remove(level.poi_activeai, var_4);

    if(!var_2)
      wait 0.25;
  }
}

findbestpoi() {
  var_0 = 5000;
  var_1 = isDefined(self.pathgoalpos);
  var_2 = isDefined(self.currentpoi);

  if(!var_2 && isDefined(self.poi_firstpoint))
    return findfirstpoiinlink();

  if(var_2 && isDefined(self.currentpoi.target) || isDefined(self.nextpoi))
    return findnextpoiinlink(var_2);
}

findfirstpoiinlink() {
  if(sighttracepassed(self getEye(), self.poi_firstpoint.origin, 0, undefined)) {
    var_0 = self.poi_firstpoint;

    if(isDefined(var_0.target))
      self.nextpoi = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(iswithinfov(var_0)) {
      return var_0;
      return;
    }

    return undefined;
    return;
  } else
    return undefined;
}

findnextpoiinlink(var_0) {
  var_1 = undefined;

  if(var_0) {
    if(isDefined(self.currentpoi.target))
      self.nextpoi = scripts\engine\utility::getStruct(self.currentpoi.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    else
      self.nextpoi = undefined;
  }

  if(isDefined(self.poi_firstpoint))
    self.poi_firstpoint = undefined;

  if(var_0 && isDefined(self.currentpoi.script_time_min))
    var_1 = self.currentpoi.script_time_min * 1000;
  else
    var_1 = 1200;

  if(!isDefined(self.nextpoi)) {
    if(gettime() < self.poi_starttime + var_1 && iswithinfov(self.currentpoi))
      return self.currentpoi;
    else {
      scripts\common\ai::poi_enable(0);
      return undefined;
    }
  }

  if(var_0 && gettime() < self.poi_starttime + var_1 && iswithinfov(self.currentpoi))
    return self.currentpoi;
  else if(!sighttracepassed(self getEye(), self.nextpoi.origin, 0, undefined))
    return undefined;
  else {
    if(!iswithinfov(self.nextpoi)) {
      if(isDefined(self.nextpoi.target))
        self.nextpoi = scripts\engine\utility::getStruct(self.nextpoi.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      else
        scripts\common\ai::poi_enable(0);

      return undefined;
    }

    return self.nextpoi;
  }
}

iswithinfov(var_0) {
  if(istrue(self.poi_disablefov))
    return 1;

  var_1 = anglesToForward(self.angles);
  var_2 = acos(vectordot(var_1, vectorNormalize(var_0.origin - self getEye())));
  return var_2 < scripts\engine\utility::ter_op(isDefined(self.poi_fovlimit), self.poi_fovlimit, 90);
}