/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3116.gsc
*********************************************/

initzombiebrute(var_0) {
  self.moveratescale = 1;
  self.bisbrute = 1;
  self.nextlaserattacktime = gettime() + 10000;
  return level.success;
}

isvalidzombietarget(var_0, var_1) {
  if(!isalive(var_0)) {
    return 0;
  }

  if(isDefined(var_0.marked_for_challenge)) {
    return 0;
  }

  if(var_0.team != self.team) {
    if(!scripts\engine\utility::istrue(var_0.is_turned)) {
      return 0;
    }
  }

  if(isDefined(var_0.agent_type)) {
    switch (var_0.agent_type) {
      case "zombie_grey":
      case "zombie_brute":
        return 0;
    }
  }

  if(scripts\engine\utility::istrue(var_0.is_traversing)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.scripted_mode)) {
    return 0;
  }

  var_2 = var_0.origin - self.origin;
  var_2 = (var_2[0], var_2[1], 0);
  var_3 = vectordot(var_2, var_1);
  if(var_3 < 0.5) {
    return 0;
  }

  var_4 = distancesquared(var_0.origin, self.origin);
  if(var_4 > 10000) {
    return 0;
  }

  return 1;
}

destroyfrozenzombies(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = scripts\mp\mp_agent::getactiveagentsoftype("all");
  self.bblockedbyfrozenzombies = undefined;
  var_3 = [];
  foreach(var_5 in var_2) {
    if(var_5 == self) {
      continue;
    }

    if(!isvalidzombietarget(var_5, var_1)) {
      continue;
    }

    if(!scripts\engine\utility::istrue(var_5.isfrozen)) {
      continue;
    }

    var_3[var_3.size] = var_5;
    if(var_3.size >= 3) {
      self.bblockedbyfrozenzombies = 1;
      return level.failure;
    }
  }

  foreach(var_5 in var_3) {
    var_5 dodamage(var_5.health + 1000, self.origin, undefined, undefined, "MOD_IMPACT");
  }

  return level.failure;
}

updatezombietarget(var_0) {
  if(isDefined(self.zombiepiece)) {
    return level.failure;
  }

  var_1 = anglesToForward(self.angles);
  if(isDefined(self.zombiepiecetarget) && isvalidzombietarget(self.zombiepiecetarget, var_1)) {
    return level.failure;
  }

  self.zombiepiecetarget = undefined;
  var_2 = scripts\mp\mp_agent::getactiveagentsoftype("all");
  foreach(var_4 in var_2) {
    if(var_4 == self) {
      continue;
    }

    if(!isvalidzombietarget(var_4, var_1)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_4.isfrozen)) {
      continue;
    }

    self.zombiepiecetarget = var_4;
    break;
  }

  return level.failure;
}

updatehelmet(var_0) {
  if(!isDefined(self.desiredhelmetlocation) || !isDefined(self.helmetlocation)) {
    return level.failure;
  }

  if(self.helmetlocation != self.desiredhelmetlocation) {
    self clearpath();
    return level.success;
  }

  return level.failure;
}

candorangeattack(var_0) {
  if(!isDefined(self.zombiepiece)) {
    return level.failure;
  }

  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  if(isDefined(self.nextthrowtime)) {
    if(gettime() < self.nextthrowtime) {
      return level.failure;
    }
  }

  var_1 = anglesToForward(self.angles);
  var_2 = self.isnodeoccupied.origin - self.origin;
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = vectornormalize(var_2);
  if(vectordot(var_1, var_2) < 0) {
    return level.failure;
  }

  if(!self getpersstat(self.isnodeoccupied)) {
    return level.failure;
  }

  return level.success;
}

cangrabzombie(var_0) {
  if(!isDefined(self.helmetlocation) || self.helmetlocation == "hand") {
    return level.failure;
  }

  if(isDefined(self.zombiepiece)) {
    return level.failure;
  }

  if(isDefined(self.zombiepiecetarget)) {
    return level.success;
  }

  return level.failure;
}

init_grabzombie(var_0) {
  self.bwanttograbzombie = 1;
}

process_grabzombie(var_0) {
  if(!isDefined(self.zombiepiecetarget)) {
    return level.failure;
  }

  if(!isDefined(self.zombietograb)) {
    var_1 = anglesToForward(self.angles);
    if(isDefined(self.zombiepiecetarget) && !isvalidzombietarget(self.zombiepiecetarget, var_1)) {
      return level.failure;
    }
  }

  if(!scripts\engine\utility::istrue(self.bwanttograbzombie)) {
    return level.failure;
  }

  return level.running;
}

terminate_grabzombie(var_0) {
  self.bwanttograbzombie = undefined;
}

init_rangeattack(var_0) {
  self.bwantrangeattack = 1;
}

process_rangeattack(var_0) {
  if(self.helmetlocation == "hand") {
    if(isDefined(self.zombiepiece)) {
      self.zombiepiece delete();
    }

    self.zombiepiece = undefined;
    return level.failure;
  }

  if(!isDefined(self.isnodeoccupied)) {
    return level.success;
  }

  if(!scripts\engine\utility::istrue(self.bwantrangeattack)) {
    return level.success;
  }

  if(scripts\engine\utility::istrue(self.bdoingrangeattack)) {
    return level.running;
  }

  var_1 = anglesToForward(self.angles);
  var_2 = self.isnodeoccupied.origin - self.origin;
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = vectornormalize(var_2);
  if(vectordot(var_1, var_2) < 0) {
    return level.failure;
  }

  if(!self getpersstat(self.isnodeoccupied)) {
    return level.failure;
  }

  return level.running;
}

terminate_rangeattack(var_0) {
  self.bwantrangeattack = undefined;
  self.nextthrowtime = gettime() + randomintrange(5000, 6000);
}

canseethroughfoliage(var_0) {
  if(!isDefined(self.helmetlocation) && self.helmetlocation == "head") {
    return level.failure;
  }

  if(isDefined(self.nextcanshoottesttime)) {
    if(gettime() < self.nextcanshoottesttime) {
      return level.failure;
    }
  }

  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  if(isDefined(self.nextlaserattacktime)) {
    if(gettime() < self.nextlaserattacktime) {
      return level.failure;
    }
  }

  if(isDefined(level.gator_mouth_trig) && self istouching(level.gator_mouth_trig)) {
    return level.failure;
  }

  var_1 = 10000;
  if(isDefined(self.last_door_loc) && distancesquared(self.last_door_loc, self.origin) < var_1) {
    return level.failure;
  }

  var_2 = distancesquared(self.isnodeoccupied.origin, self.origin);
  if(var_2 > 562500) {
    return level.failure;
  }

  if(var_2 < -25536) {
    return level.failure;
  }

  if(!self getpersstat(self.isnodeoccupied)) {
    self.last_enemy_seen_time = undefined;
    return level.failure;
  }

  var_3 = gettime();
  if(!isDefined(self.last_enemy_seen_time) || !isDefined(self.last_enemy_seen) || self.last_enemy_seen != self.isnodeoccupied) {
    self.last_enemy_seen_time = var_3;
    self.last_enemy_seen = self.isnodeoccupied;
    return level.failure;
  }

  if(var_3 - self.last_enemy_seen_time < 1500) {
    return level.failure;
  }

  var_4 = scripts\common\trace::create_contents(1, 1, 1, 0, 1, 0, 0);
  self.nextcanshoottesttime = var_3 + 250;
  var_5 = 0;
  var_6 = [];
  foreach(var_8 in level.agentarray) {
    if(isalive(var_8)) {
      var_6[var_5] = var_8;
      var_5++;
    }
  }

  if(isDefined(self.helmet)) {
    var_6[var_6.size] = self.helmet;
  }

  var_0A = self.isnodeoccupied getsecondspassed();
  var_0B = physics_spherecast(self gettagorigin("tag_eye"), var_0A, 10, var_4, var_6, "physicsquery_closest");
  if(isDefined(var_0B) && var_0B.size > 0) {
    if(isDefined(var_0B[0]["hittype"]) && var_0B[0]["hittype"] == "hittype_entity") {
      if(var_0B[0]["entity"] == self.isnodeoccupied) {
        return level.success;
      }
    }
  }

  self.last_enemy_seen_time = var_3;
  return level.failure;
}

init_laserattack(var_0) {
  self.blaserattack = 1;
  self.laserattackstarttime = undefined;
  self.laserenemy = self.isnodeoccupied;
  self.laserfailsafetime = gettime() + 3000;
}

process_laserattack(var_0) {
  if(!isDefined(self.laserenemy) || !isDefined(self.isnodeoccupied) || self.isnodeoccupied != self.laserenemy) {
    return level.failure;
  }

  if(!scripts\engine\utility::istrue(self.blaserattackstarted)) {
    if(gettime() > self.laserfailsafetime) {
      return level.failure;
    }

    return level.running;
  }

  if(!isDefined(self.laserattackstarttime)) {
    self.laserattackstarttime = gettime();
  }

  if(scripts\engine\utility::istrue(self.blaserattack)) {
    if(gettime() < self.laserattackstarttime + 6000) {
      return level.running;
    }
  }

  return level.failure;
}

terminate_laserattack(var_0) {
  self.blaserattack = 0;
  self.laserenemy = undefined;
  self.nextlaserattacktime = gettime() + randomintrange(5000, 10000);
  self.last_enemy_seen_time = undefined;
  self.last_enemy_seen = undefined;
  self.laserfailsafetime = undefined;
}

shoulddoempattack(var_0) {
  return level.failure;
}

init_empattack(var_0) {}

process_empattack(var_0) {
  return level.failure;
}

terminate_empattack(var_0) {}