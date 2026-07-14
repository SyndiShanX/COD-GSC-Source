/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\cqb.gsc
**************************************/

#using scripts\asm\track;
#using scripts\common\ai;
#using scripts\engine\utility;
#namespace cqb;

function setupcqbpointsofinterest() {
  level.cqbpointsofinterest = [];
  level.fnfindcqbpointsofinterest = &findcqbpointsofinterest;

  level.fncqbdebug = &cqbdebug;

  thread gatherdynamiccqbstructs();
}

function gatherdynamiccqbstructs() {
  waittillframeend();
  targetname = "\xfa!\xa3";
  pointstructs = utility::getStructArray(targetname, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

  foreach(point in pointstructs) {
    level.cqbpointsofinterest[level.cqbpointsofinterest.size] = point;
  }
}

function function_3b82f08da5cff8f1(poi) {
  if(!isDefined(poi)) {
    if(isDefined(self.cqb_point_of_interest)) {
      self.cqb_point_of_interest = undefined;
      self function_5435fc244bfd19a8(0);
    }

    return;
  }

  if(self.cqb_point_of_interest != poi) {
    assert(isDefined(poi.origin));
    self.cqb_point_of_interest = poi;
    self function_5435fc244bfd19a8(1, poi.origin, istrue(poi.script_poi_forcestrafe), istrue(poi.islookatonly), poi.lookatduration);
  }
}

function findcqbpointsofinterest() {
  if(isDefined(anim.findingcqbpointsofinterest)) {
    return;
  }

  anim.findingcqbpointsofinterest = 1;

  level thread cqbdebug();

  waitframe();

  while(true) {
    ai = level.poi_activeai;

    if(!isDefined(ai)) {
      waitframe();
      continue;
    }

    guystoremove = [];
    waited = 0;

    foreach(guy in ai) {
      if(isalive(guy)) {
        guy function_3b82f08da5cff8f1(guy findbestpoi());
        wait 0.05;
        waited = 1;
        continue;
      }

      guystoremove[guystoremove.size] = guy;
    }

    foreach(guy in guystoremove) {
      level.poi_activeai = arrayremove(level.poi_activeai, guy);
    }

    if(!waited) {
      wait 0.25;
    }
  }
}

function findbestpoi() {
  var_33bc6f482f893f55 = 5000;
  ismoving = isDefined(self.pathgoalpos);
  currentpoi = track::getcurrentpoi();
  haspoi = isDefined(currentpoi);

  if(!haspoi && isDefined(self.poi_firstpoint)) {
    return findfirstpoiinlink();
  }

  if(haspoi && isDefined(currentpoi.target) || isDefined(self.nextpoi)) {
    return findnextpoiinlink(haspoi);
  }
}

function findfirstpoiinlink() {
  assert(isDefined(self.poi_firstpoint));

  if(sighttracepassed(self getEye(), self.poi_firstpoint.origin, 0, undefined)) {
    poi = self.poi_firstpoint;

    if(isDefined(poi.target)) {
      self.nextpoi = utility::getStruct(poi.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    }

    if(iswithinfov(poi)) {
      return poi;
    } else {
      return undefined;
    }

    return;
  }

  return undefined;
}

function findnextpoiinlink(haspoi) {
  min_time = undefined;
  currentpoi = track::getcurrentpoi();
  assert(haspoi && isDefined(currentpoi.target) || isDefined(self.nextpoi));

  if(haspoi) {
    if(isDefined(currentpoi.target)) {
      self.nextpoi = utility::getStruct(currentpoi.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    } else {
      self.nextpoi = undefined;
    }
  }

  if(isDefined(self.poi_firstpoint)) {
    self.poi_firstpoint = undefined;
  }

  if(haspoi && isDefined(currentpoi.script_time_min)) {
    min_time = currentpoi.script_time_min * 1000;
  } else {
    min_time = 1200;
  }

  if(!isDefined(self.nextpoi)) {
    if(gettime() < self.poi_starttime + min_time && iswithinfov(currentpoi)) {
      return currentpoi;
    } else {
      ai::poi_enable(0);
      return undefined;
    }
  }

  if(haspoi && gettime() < self.poi_starttime + min_time && iswithinfov(currentpoi)) {
    return currentpoi;
  }

  if(!sighttracepassed(self getEye(), self.nextpoi.origin, 0, undefined)) {
    return undefined;
  }

  if(!iswithinfov(self.nextpoi)) {
    if(isDefined(self.nextpoi.target)) {
      self.nextpoi = utility::getStruct(self.nextpoi.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    } else {
      ai::poi_enable(0);
    }

    return undefined;
  }

  return self.nextpoi;
}

function iswithinfov(poi) {
  if(istrue(self.poi_disablefov)) {
    return true;
  }

  assert(isDefined(poi));
  myforward = anglesToForward(self.angles);
  var_fa8e5c9f73f568bb = acos(vectordot(myforward, vectorNormalize(poi.origin - self getEye())));
  return var_fa8e5c9f73f568bb < (self.poi_fovlimit ?? 90);
}

function cqbdebug() {
  self notify("<dev string:x24>");
  self endon("<dev string:x24>");
  self endon("<dev string:x35>");
  level thread cqbdebugglobal();
}

function cqbdebugglobal() {
  setdvarifuninitialized(@ "hash_e37c013185c9347c", "<dev string:x3e>");

  if(isDefined(level.cqbdebugglobal)) {
    return;
  }

  level.cqbdebugglobal = 1;

  while(true) {
    if(getDvar(@ "hash_e37c013185c9347c") != "<dev string:x43>") {
      wait 1;
      continue;
    }

    foreach(ai in level.poi_activeai) {
      currentpoi = ai track::getcurrentpoi();

      if(isDefined(currentpoi)) {
        line(ai getEye(), currentpoi.origin, (0, 0, 1), 1, 0, 1);
        continue;
      }

      if(isDefined(ai.nextpoi)) {
        line(ai getEye(), ai.nextpoi.origin, (1, 0, 0), 1, 0, 1);
        continue;
      }

      if(isDefined(ai.poi_firstpoint)) {
        line(ai getEye(), ai.poi_firstpoint.origin, (1, 0, 0), 1, 0, 1);
      }
    }

    wait 0.05;
  }
}

# /