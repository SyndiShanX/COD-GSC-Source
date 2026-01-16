/******************************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_brute\behaviors.gsc
******************************************************/

initzombiebrute(var_0) {
  self.moveratescale = 1.0;
  self.bisbrute = 1;
  self.nextlaserattacktime = gettime() + 10000;
  return anim.success;
}

isvalidzombietarget(var_0, var_1) {
  if(!isalive(var_0)) {
    return 0;
  }

  if(isDefined(var_0.marked_for_challenge)) {
    return 0;
  }

  if(var_0.team != self.team) {
    if(!scripts\engine\utility::is_true(var_0.is_turned)) {
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

  if(scripts\engine\utility::is_true(var_0.is_traversing)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(var_0.scripted_mode)) {
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
    if(!scripts\engine\utility::is_true(var_5.isfrozen)) {
      continue;
    }
    var_3[var_3.size] = var_5;

    if(var_3.size >= 3) {
      self.bblockedbyfrozenzombies = 1;
      return anim.failure;
    }
  }

  foreach(var_5 in var_3) {
    var_5 dodamage(var_5.health + 1000, self.origin, undefined, undefined, "MOD_IMPACT");
  }

  return anim.failure;
}

updatezombietarget(var_0) {
  if(isDefined(self.zombiepiece)) {
    return anim.failure;
  }

  var_1 = anglesToForward(self.angles);

  if(isDefined(self.zombiepiecetarget) && isvalidzombietarget(self.zombiepiecetarget, var_1)) {
    return anim.failure;
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
    if(scripts\engine\utility::is_true(var_4.isfrozen)) {
      continue;
    }
    self.zombiepiecetarget = var_4;
    break;
  }

  return anim.failure;
}

updatehelmet(var_0) {
  if(!isDefined(self.desiredhelmetlocation) || !isDefined(self.helmetlocation)) {
    return anim.failure;
  }

  if(self.helmetlocation != self.desiredhelmetlocation) {
    self clearpath();
    return anim.success;
  }

  return anim.failure;
}

candorangeattack(var_0) {
  if(!isDefined(self.zombiepiece)) {
    return anim.failure;
  }

  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(isDefined(self.nextthrowtime)) {
    if(gettime() < self.nextthrowtime) {
      return anim.failure;
    }
  }

  var_1 = anglesToForward(self.angles);
  var_2 = self.enemy.origin - self.origin;
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = vectornormalize(var_2);

  if(vectordot(var_1, var_2) < 0) {
    return anim.failure;
  }

  if(!self cansee(self.enemy)) {
    return anim.failure;
  }

  return anim.success;
}

cangrabzombie(var_0) {
  if(!isDefined(self.helmetlocation) || self.helmetlocation == "hand") {
    return anim.failure;
  }

  if(isDefined(self.zombiepiece)) {
    return anim.failure;
  }

  if(isDefined(self.zombiepiecetarget)) {
    return anim.success;
  }

  return anim.failure;
}

init_grabzombie(var_0) {
  self.bwanttograbzombie = 1;
}

process_grabzombie(var_0) {
  if(!isDefined(self.zombiepiecetarget)) {
    return anim.failure;
  }

  if(!isDefined(self.zombietograb)) {
    var_1 = anglesToForward(self.angles);

    if(isDefined(self.zombiepiecetarget) && !isvalidzombietarget(self.zombiepiecetarget, var_1)) {
      return anim.failure;
    }
  }

  if(!scripts\engine\utility::is_true(self.bwanttograbzombie)) {
    return anim.failure;
  }

  return anim.running;
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
    return anim.failure;
  }

  if(!isDefined(self.enemy)) {
    return anim.success;
  }

  if(!scripts\engine\utility::is_true(self.bwantrangeattack)) {
    return anim.success;
  }

  if(scripts\engine\utility::is_true(self.bdoingrangeattack)) {
    return anim.running;
  }

  var_1 = anglesToForward(self.angles);
  var_2 = self.enemy.origin - self.origin;
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = vectornormalize(var_2);

  if(vectordot(var_1, var_2) < 0) {
    return anim.failure;
  }

  if(!self cansee(self.enemy)) {
    return anim.failure;
  }

  return anim.running;
}

terminate_rangeattack(var_0) {
  self.bwantrangeattack = undefined;
  self.nextthrowtime = gettime() + randomintrange(5000, 6000);
}

canseethroughfoliage(var_0) {
  if(!(isDefined(self.helmetlocation) && self.helmetlocation == "head")) {
    return anim.failure;
  }

  if(isDefined(self.nextcanshoottesttime)) {
    if(gettime() < self.nextcanshoottesttime) {
      return anim.failure;
    }
  }

  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(isDefined(self.nextlaserattacktime)) {
    if(gettime() < self.nextlaserattacktime) {
      return anim.failure;
    }
  }

  if(isDefined(level.gator_mouth_trig) && self istouching(level.gator_mouth_trig)) {
    return anim.failure;
  }

  var_1 = 10000;

  if(isDefined(self.last_door_loc) && distancesquared(self.last_door_loc, self.origin) < var_1) {
    return anim.failure;
  }

  var_2 = distancesquared(self.enemy.origin, self.origin);

  if(var_2 > 562500) {
    return anim.failure;
  }

  if(var_2 < 40000) {
    return anim.failure;
  }

  if(!self cansee(self.enemy)) {
    self.last_enemy_seen_time = undefined;
    return anim.failure;
  }

  var_3 = gettime();

  if(!isDefined(self.last_enemy_seen_time) || !isDefined(self.last_enemy_seen) || self.last_enemy_seen != self.enemy) {
    self.last_enemy_seen_time = var_3;
    self.last_enemy_seen = self.enemy;
    return anim.failure;
  }

  if(var_3 - self.last_enemy_seen_time < 1500) {
    return anim.failure;
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

  var_10 = self.enemy getsecondspassed();
  var_11 = physics_spherecast(self gettagorigin("tag_eye"), var_10, 10, var_4, var_6, "physicsquery_closest");

  if(isDefined(var_11) && var_11.size > 0) {
    if(isDefined(var_11[0]["hittype"]) && var_11[0]["hittype"] == "hittype_entity") {
      if(var_11[0]["entity"] == self.enemy) {
        return anim.success;
      }
    }
  }

  self.last_enemy_seen_time = var_3;
  return anim.failure;
}

init_laserattack(var_0) {
  self.blaserattack = 1;
  self.laserattackstarttime = undefined;
  self.laserenemy = self.enemy;
  self.laserfailsafetime = gettime() + 3000;
}

process_laserattack(var_0) {
  if(!isDefined(self.laserenemy) || !isDefined(self.enemy) || self.enemy != self.laserenemy) {
    return anim.failure;
  }

  if(!scripts\engine\utility::is_true(self.blaserattackstarted)) {
    if(gettime() > self.laserfailsafetime) {
      return anim.failure;
    }

    return anim.running;
  }

  if(!isDefined(self.laserattackstarttime)) {
    self.laserattackstarttime = gettime();
  }

  if(scripts\engine\utility::is_true(self.blaserattack)) {
    if(gettime() < self.laserattackstarttime + 6000) {
      return anim.running;
    }
  }

  return anim.failure;
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
  return anim.failure;
}

init_empattack(var_0) {}

process_empattack(var_0) {
  return anim.failure;
}

terminate_empattack(var_0) {}