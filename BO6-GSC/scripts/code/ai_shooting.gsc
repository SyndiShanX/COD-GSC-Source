/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\code\ai_shooting.gsc
****************************************/

#namespace ai_shooting;

function decidenumshotsformg() {
  turret = undefined;

  if(isDefined(self.fngetusedturret)) {
    turret = [[self.fngetusedturret]]();
  }

  usingturret = isDefined(turret);

  if(usingturret && isDefined(turret.script_burst_min)) {
    bursttime = turret.script_burst_min;
  } else {
    bursttime = 0.5;
  }

  if(usingturret && isDefined(turret.script_burst_max)) {
    burstrange = turret.script_burst_max - bursttime;
  } else {
    burstrange = 1.5;
  }

  burst_length = bursttime + randomfloat(burstrange);
  return int(burst_length * 10);
}

function decidenumshotsforfull() {
  numshots = self.bulletsinclip;
  weapclass = weaponclass(self.weapon);

  if(weaponclass(self.weapon) == "\b5") {
    choice = randomfloat(10);

    if(choice < 3) {
      numshots = randomintrange(2, 6);
    } else if(choice < 8) {
      numshots = randomintrange(6, 12);
    } else {
      numshots = randomintrange(12, 20);
    }
  }

  return numshots;
}

function decidenumshotsforburst(distancetoenemysquared) {
  maxburst = 5;
  fixedburstcount = weaponburstcount(self.weapon);

  if(fixedburstcount) {
    numshots = fixedburstcount;
  } else {
    numshots = reduceshotcountbydistance(maxburst, distancetoenemysquared);
    numshots += randomintrange(-2, 3);
    numshots = int(max(numshots, 1));
  }

  if(numshots <= self.bulletsinclip) {
    return numshots;
  }

  assert(self.bulletsinclip >= 0, self.bulletsinclip);

  if(self.bulletsinclip <= 0) {
    return 1;
  }

  return self.bulletsinclip;
}

function reduceshotcountbydistance(var_93c05c7c759d293d, distancetoenemysquared) {
  fullautorangesq = 62500;
  var_85dd29914baf4212 = 810000;
  var_45d0a0409a6235ea = 1562500;
  singleshotrangesq = 2560000;
  alldistances = [fullautorangesq, var_85dd29914baf4212, var_45d0a0409a6235ea, singleshotrangesq];
  assert(var_93c05c7c759d293d > alldistances.size);

  foreach(currentdistance in alldistances) {
    if(distancetoenemysquared > currentdistance) {
      var_93c05c7c759d293d -= 1;
    }
  }

  return var_93c05c7c759d293d;
}