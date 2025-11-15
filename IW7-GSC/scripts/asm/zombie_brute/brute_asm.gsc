/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3116.gsc
************************/

initzombiebrute(param_00) {
  self.moveratescale = 1;
  self.bisbrute = 1;
  self.nextlaserattacktime = gettime() + 10000;
  return level.success;
}

isvalidzombietarget(param_00, param_01) {
  if(!isalive(param_00)) {
    return 0;
  }

  if(isDefined(param_00.marked_for_challenge)) {
    return 0;
  }

  if(param_00.team != self.team) {
    if(!scripts\engine\utility::istrue(param_00.is_turned)) {
      return 0;
    }
  }

  if(isDefined(param_00.agent_type)) {
    switch (param_00.agent_type) {
      case "zombie_grey":
      case "zombie_brute":
        return 0;
    }
  }

  if(scripts\engine\utility::istrue(param_00.is_traversing)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_00.scripted_mode)) {
    return 0;
  }

  var_02 = param_00.origin - self.origin;
  var_02 = (var_02[0], var_02[1], 0);
  var_03 = vectordot(var_02, param_01);
  if(var_03 < 0.5) {
    return 0;
  }

  var_04 = distancesquared(param_00.origin, self.origin);
  if(var_04 > 10000) {
    return 0;
  }

  return 1;
}

destroyfrozenzombies(param_00) {
  var_01 = anglesToForward(self.angles);
  var_02 = scripts\mp\mp_agent::getactiveagentsoftype("all");
  self.bblockedbyfrozenzombies = undefined;
  var_03 = [];
  foreach(var_05 in var_02) {
    if(var_05 == self) {
      continue;
    }

    if(!isvalidzombietarget(var_05, var_01)) {
      continue;
    }

    if(!scripts\engine\utility::istrue(var_05.isfrozen)) {
      continue;
    }

    var_03[var_03.size] = var_05;
    if(var_03.size >= 3) {
      self.bblockedbyfrozenzombies = 1;
      return level.failure;
    }
  }

  foreach(var_05 in var_03) {
    var_05 dodamage(var_05.health + 1000, self.origin, undefined, undefined, "MOD_IMPACT");
  }

  return level.failure;
}

updatezombietarget(param_00) {
  if(isDefined(self.zombiepiece)) {
    return level.failure;
  }

  var_01 = anglesToForward(self.angles);
  if(isDefined(self.zombiepiecetarget) && isvalidzombietarget(self.zombiepiecetarget, var_01)) {
    return level.failure;
  }

  self.zombiepiecetarget = undefined;
  var_02 = scripts\mp\mp_agent::getactiveagentsoftype("all");
  foreach(var_04 in var_02) {
    if(var_04 == self) {
      continue;
    }

    if(!isvalidzombietarget(var_04, var_01)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_04.isfrozen)) {
      continue;
    }

    self.zombiepiecetarget = var_04;
    break;
  }

  return level.failure;
}

updatehelmet(param_00) {
  if(!isDefined(self.desiredhelmetlocation) || !isDefined(self.helmetlocation)) {
    return level.failure;
  }

  if(self.helmetlocation != self.desiredhelmetlocation) {
    self clearpath();
    return level.success;
  }

  return level.failure;
}

candorangeattack(param_00) {
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

  var_01 = anglesToForward(self.angles);
  var_02 = self.isnodeoccupied.origin - self.origin;
  var_02 = (var_02[0], var_02[1], 0);
  var_02 = vectornormalize(var_02);
  if(vectordot(var_01, var_02) < 0) {
    return level.failure;
  }

  if(!self getpersstat(self.isnodeoccupied)) {
    return level.failure;
  }

  return level.success;
}

cangrabzombie(param_00) {
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

init_grabzombie(param_00) {
  self.bwanttograbzombie = 1;
}

process_grabzombie(param_00) {
  if(!isDefined(self.zombiepiecetarget)) {
    return level.failure;
  }

  if(!isDefined(self.zombietograb)) {
    var_01 = anglesToForward(self.angles);
    if(isDefined(self.zombiepiecetarget) && !isvalidzombietarget(self.zombiepiecetarget, var_01)) {
      return level.failure;
    }
  }

  if(!scripts\engine\utility::istrue(self.bwanttograbzombie)) {
    return level.failure;
  }

  return level.running;
}

terminate_grabzombie(param_00) {
  self.bwanttograbzombie = undefined;
}

init_rangeattack(param_00) {
  self.bwantrangeattack = 1;
}

process_rangeattack(param_00) {
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

  var_01 = anglesToForward(self.angles);
  var_02 = self.isnodeoccupied.origin - self.origin;
  var_02 = (var_02[0], var_02[1], 0);
  var_02 = vectornormalize(var_02);
  if(vectordot(var_01, var_02) < 0) {
    return level.failure;
  }

  if(!self getpersstat(self.isnodeoccupied)) {
    return level.failure;
  }

  return level.running;
}

terminate_rangeattack(param_00) {
  self.bwantrangeattack = undefined;
  self.nextthrowtime = gettime() + randomintrange(5000, 6000);
}

canseethroughfoliage(param_00) {
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

  var_01 = 10000;
  if(isDefined(self.last_door_loc) && distancesquared(self.last_door_loc, self.origin) < var_01) {
    return level.failure;
  }

  var_02 = distancesquared(self.isnodeoccupied.origin, self.origin);
  if(var_02 > 562500) {
    return level.failure;
  }

  if(var_02 < -25536) {
    return level.failure;
  }

  if(!self getpersstat(self.isnodeoccupied)) {
    self.last_enemy_seen_time = undefined;
    return level.failure;
  }

  var_03 = gettime();
  if(!isDefined(self.last_enemy_seen_time) || !isDefined(self.last_enemy_seen) || self.last_enemy_seen != self.isnodeoccupied) {
    self.last_enemy_seen_time = var_03;
    self.last_enemy_seen = self.isnodeoccupied;
    return level.failure;
  }

  if(var_03 - self.last_enemy_seen_time < 1500) {
    return level.failure;
  }

  var_04 = scripts\common\trace::create_contents(1, 1, 1, 0, 1, 0, 0);
  self.nextcanshoottesttime = var_03 + 250;
  var_05 = 0;
  var_06 = [];
  foreach(var_08 in level.agentarray) {
    if(isalive(var_08)) {
      var_06[var_05] = var_08;
      var_05++;
    }
  }

  if(isDefined(self.helmet)) {
    var_06[var_06.size] = self.helmet;
  }

  var_0A = self.isnodeoccupied getsecondspassed();
  var_0B = physics_spherecast(self gettagorigin("tag_eye"), var_0A, 10, var_04, var_06, "physicsquery_closest");
  if(isDefined(var_0B) && var_0B.size > 0) {
    if(isDefined(var_0B[0]["hittype"]) && var_0B[0]["hittype"] == "hittype_entity") {
      if(var_0B[0]["entity"] == self.isnodeoccupied) {
        return level.success;
      }
    }
  }

  self.last_enemy_seen_time = var_03;
  return level.failure;
}

init_laserattack(param_00) {
  self.blaserattack = 1;
  self.laserattackstarttime = undefined;
  self.laserenemy = self.isnodeoccupied;
  self.laserfailsafetime = gettime() + 3000;
}

process_laserattack(param_00) {
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

terminate_laserattack(param_00) {
  self.blaserattack = 0;
  self.laserenemy = undefined;
  self.nextlaserattacktime = gettime() + randomintrange(5000, 10000);
  self.last_enemy_seen_time = undefined;
  self.last_enemy_seen = undefined;
  self.laserfailsafetime = undefined;
}

shoulddoempattack(param_00) {
  return level.failure;
}

init_empattack(param_00) {}

process_empattack(param_00) {
  return level.failure;
}

terminate_empattack(param_00) {}