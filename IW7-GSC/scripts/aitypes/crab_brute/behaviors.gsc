/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\crab_brute\behaviors.gsc
****************************************************/

initbehaviors(var_0) {
  setupbehaviorstates();
  self.desiredaction = undefined;
  self.lastenemyengagetime = 0;
  self.myenemy = undefined;
  scripts\asm\asm_bb::bb_requestmovetype("run");
  return level.success;
}

setupbehaviorstates() {
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("melee_attack", ::melee_begin, ::melee_tick, ::melee_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("burrow", ::burrow_begin, ::burrow_tick, ::burrow_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("summon", ::summon_begin, ::summon_tick, ::summon_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("charge", ::charge_begin, ::charge_tick, ::charge_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("flash", ::flash_begin, ::flash_tick, ::flash_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("taunt", ::taunt_begin, ::taunt_tick, ::taunt_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("tired", ::tired_begin, ::tired_tick, ::tired_end);
}

pickbetterenemy(var_0, var_1) {
  var_2 = self getpersstat(var_0);
  var_3 = self getpersstat(var_1);
  if(var_2 != var_3) {
    if(var_2) {
      return var_0;
    }

    return var_1;
  }

  var_4 = distancesquared(self.origin, var_0.origin);
  var_5 = distancesquared(self.origin, var_1.origin);
  if(var_4 < var_5) {
    return var_0;
  }

  return var_1;
}

updateenemy() {
  if(isDefined(self.myenemy) && !scripts\mp\agents\crab_brute\crab_brute_agent::shouldignoreenemy(self.myenemy)) {
    if(gettime() - self.myenemystarttime < 3000) {
      return self.myenemy;
    }
  }

  var_0 = undefined;
  foreach(var_2 in level.players) {
    if(scripts\mp\agents\crab_brute\crab_brute_agent::shouldignoreenemy(var_2)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_2.isfasttravelling)) {
      continue;
    }

    if(!isDefined(var_0)) {
      var_0 = var_2;
      continue;
    }

    var_0 = pickbetterenemy(var_0, var_2);
  }

  if(!isDefined(var_0)) {
    self.myenemy = undefined;
    return undefined;
  }

  if(!isDefined(self.myenemy) || var_0 != self.myenemy) {
    self.myenemy = var_0;
    self.myenemystarttime = gettime();
  }
}

updateeveryframe(var_0) {
  updateenemy();
  return level.failure;
}

melee_begin(var_0) {
  var_1 = scripts\aitypes\dlc3\bt_action_api::getcurrentdesiredaction(var_0);
  scripts\asm\crab_brute\crab_brute_asm::setaction(var_1);
  var_2 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  var_3 = var_2 getvelocity();
  var_4 = length2dsquared(var_3);
  if(var_4 < 144) {
    self clearpath();
  } else {
    self.bmovingmelee = 1;
  }

  self.curmeleetarget = var_2;
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, var_1, var_1);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, var_1);
}

melee_tick(var_0) {
  self clearpath();
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.failure;
}

melee_end(var_0) {
  self.curmeleetarget = undefined;
  self.bmovingmelee = undefined;
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
  scripts\aitypes\dlc3\bt_state_api::btstate_endstates(var_0);
}

burrow_begin(var_0) {
  scripts\asm\crab_brute\crab_brute_asm::setaction("burrow");
  var_1 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_2 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(isDefined(var_2)) {
    var_3 = var_2.origin;
    if(isDefined(self.vehicle_getspawnerarray)) {
      var_3 = self getposonpath(32);
    }

    var_4 = scripts\engine\utility::getyawtospot(var_3);
    if(abs(var_4) > 45) {
      self.desiredyaw = var_4;
    }
  }

  var_5 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_6 = randomfloatrange(var_1.min_burrow_goal_radius, var_1.max_burrow_goal_radius);
  var_5.desiredradiussq = var_6 * var_6;
}

burrow_tick(var_0) {
  var_1 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_2 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  if(scripts\engine\utility::istrue(var_2.bburrowisdone)) {
    return level.success;
  }

  var_3 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_3)) {
    burrow_stop(var_0);
    return level.running;
  } else {
    var_4 = distancesquared(self.origin, var_3.origin);
    if(var_4 < var_2.desiredradiussq) {
      burrow_stop(var_0);
      return level.running;
    }
  }

  var_5 = self getvelocity() * (1, 1, 0);
  var_6 = self getposonpath(length2d(var_5) * var_1.burrow_look_ahead_time);
  var_7 = var_6 + (0, 0, 40);
  var_8 = var_6 - (0, 0, 60);
  var_9 = scripts\common\trace::ray_trace(var_7, var_8, self, undefined, 1, 1);
  if(isDefined(var_9)) {
    var_0A = var_9["surfacetype"];
    if(!isvalidburrowsurface(var_0A)) {
      burrow_stop(var_0);
      return level.running;
    }
  }

  var_0B = getclosestpointonnavmesh(var_3.origin, self);
  self ghostskulls_complete_status(var_0B);
  return level.running;
}

burrow_end(var_0) {
  self.desiredyaw = undefined;
  self clearpath();
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
}

burrow_stop(var_0) {
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_1.bburrowisdone = undefined;
  var_1.desiredradiussq = undefined;
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "burrow_popup", "burrow_outro", ::burrow_outro_done, undefined, undefined, 1000);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "burrow_popup");
}

burrow_outro_done(var_0, var_1) {
  var_2 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_2.bburrowisdone = 1;
  var_3 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_4 = 0;
  var_4 = var_4 + var_3.post_burrow_charge_chance;
  var_4 = var_4 + var_3.post_burrow_taunt_chance;
  var_4 = var_4 + var_3.post_burrow_flash_chance;
  var_4 = var_4 + var_3.post_burrow_summon_chance;
  var_4 = var_4 + var_3.post_burrow_nothing_chance;
  var_5 = randomint(var_4);
  var_6 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_6)) {
    return 0;
  }

  var_7 = distancesquared(var_6.origin, self.origin);
  if(trymeleeattacks(var_7)) {
    return 0;
  }

  if(var_5 < var_3.post_burrow_charge_chance) {
    if(trycharge(var_0, var_7, 1)) {
      return 0;
    }
  }

  var_5 = var_5 - var_3.post_burrow_charge_chance;
  if(var_5 < var_3.post_burrow_flash_chance) {
    if(tryflash(var_0, var_7, 1)) {
      return 0;
    }
  }

  var_5 = var_5 - var_3.post_burrow_charge_chance;
  if(var_5 < var_3.post_burrow_flash_chance) {
    if(trysummon(var_0, var_7, 1)) {
      return 0;
    }
  }

  var_5 = var_5 - var_3.post_burrow_taunt_chance;
  if(var_5 < var_3.post_burrow_taunt_chance) {
    if(trytaunt(var_0, var_7, 1)) {
      return 0;
    }
  }

  return 0;
}

isvalidburrowsurface(var_0) {
  switch (var_0) {
    case "surftype_none":
    case "surftype_dirt":
    case "surftype_grass":
    case "surftype_sand":
      break;

    default:
      return 0;
  }

  return 1;
}

isvalidburrowpath() {
  var_0 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_1 = sqrt(var_0.burrow_mindist_sq) + var_0.max_burrow_goal_radius;
  var_2 = 0;
  for(var_3 = undefined; var_2 < var_1; var_3 = var_4) {
    var_4 = self getposonpath(var_2);
    if(isDefined(var_3) && distance2dsquared(var_3, var_4) < 64) {
      return 0;
    }

    var_5 = var_4 + (0, 0, 40);
    var_6 = var_4 - (0, 0, 60);
    var_7 = scripts\common\trace::ray_trace(var_5, var_6, self, undefined, 1, 1);
    var_8 = var_7["surfacetype"];
    if(!isvalidburrowsurface(var_8)) {
      return 0;
    }

    var_2 = var_2 + var_0.burrow_path_check_interval_dist;
  }

  return 1;
}

tryburrow(var_0, var_1) {
  if(isDefined(self.nextburrowtesttime) && gettime() < self.nextburrowtesttime) {
    return 0;
  }

  var_2 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  if(!isDefined(self.nextburrowtesttime)) {
    self.nextburrowtesttime = gettime() + var_2.initial_burrow_wait_time_ms;
  }

  self.nextburrowtesttime = gettime() + 500;
  var_3 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_3)) {
    return 0;
  }

  if(!isDefined(var_1)) {
    var_1 = distancesquared(var_3.origin, self.origin);
  }

  if(var_1 < var_2.burrow_mindist_sq) {
    return 0;
  }

  if(var_1 > var_2.burrow_maxdist_sq) {
    return 0;
  }

  var_4 = scripts\common\trace::ray_trace(self.origin + (0, 0, 40), self.origin - (0, 0, 40), self, undefined, 1, 1);
  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = var_4["surfacetype"];
  if(!isvalidburrowsurface(var_5)) {
    return 0;
  }

  if(isDefined(self.vehicle_getspawnerarray)) {
    if(!isvalidburrowpath()) {
      self.nextburrowtesttime = gettime() + 1500;
      return 0;
    }
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "burrow");
  return 1;
}

charge_begin(var_0) {
  scripts\asm\crab_brute\crab_brute_asm::setaction("charge");
  var_1 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_2 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  self.curmeleetarget = var_2;
  if(isDefined(var_2)) {
    var_3 = scripts\engine\utility::getyawtospot(var_2.origin);
    if(abs(var_3) > 45) {
      self.desiredyaw = var_3;
    }
  }

  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "charging", "charge_loop", ::charge_movedone, undefined, var_1.max_charge_time_ms, 2000);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "charging");
}

charge_tick(var_0) {
  if(!isDefined(self.curmeleetarget) || scripts\mp\agents\crab_brute\crab_brute_agent::shouldignoreenemy(self.curmeleetarget)) {
    return level.failure;
  }

  self ghostskulls_complete_status(self.curmeleetarget.origin);
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  var_1 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(isDefined(var_1)) {
    var_2 = distancesquared(var_1.origin, self.origin);
    if(trymeleeattacks(var_2)) {
      return level.success;
    }

    if(trysummon(var_0, 1409865409, 1)) {
      return level.success;
    }

    if(tryflash(var_0, 1409865409, 1, 1)) {
      return level.success;
    }

    scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "taunt");
  }

  return level.success;
}

charge_end(var_0) {
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
  self.curmeleetarget = undefined;
  self.bchargehit = undefined;
  self.desiredyaw = undefined;
  self clearpath();
  var_1 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  self.nextchargeattacktesttime = gettime() + randomintrange(var_1.min_charge_attack_interval_ms, var_1.max_charge_attack_interval_ms);
}

charge_movedone(var_0, var_1) {
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "charge_end", "charge_outro", ::charge_enddone);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "charge_end");
  return 1;
}

charge_enddone(var_0, var_1) {
  return 0;
}

trycharge(var_0, var_1, var_2) {
  if(!scripts\engine\utility::istrue(var_2)) {
    if(isDefined(self.nextchargeattacktesttime) && gettime() < self.nextchargeattacktesttime) {
      return 0;
    }
  }

  var_3 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_4 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_4)) {
    return 0;
  }

  if(!isDefined(var_1)) {
    var_1 = distancesquared(var_4.origin, self.origin);
  }

  if(var_1 < var_3.charge_attack_mindist_sq) {
    return 0;
  }

  if(var_1 > var_3.charge_attack_maxdist_sq) {
    return 0;
  }

  self.nextchargeattacktesttime = gettime() + 5000;
  var_5 = anglesToForward(self.angles);
  var_6 = var_4.origin;
  var_7 = var_6 - self.origin;
  var_5 = (var_5[0], var_5[1], 0);
  var_7 = vectornormalize((var_7[0], var_7[1], 0));
  var_8 = vectordot(var_5, var_7);
  if(var_8 < 0.707) {
    return 0;
  }

  if(!navisstraightlinereachable(self.origin, var_6, self)) {
    self.nextchargeattacktesttime = gettime() + 500;
    return 0;
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "charge");
  return 1;
}

tired_begin(var_0) {
  self clearpath();
  self.bforceallowpain = 1;
  scripts\asm\crab_brute\crab_brute_asm::setaction("tired");
  var_1 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_2 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_2.endtiredtime = gettime() + randomintrange(var_1.min_tired_time_ms, var_1.max_tired_time_ms);
}

tired_tick(var_0) {
  self clearpath();
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  if(gettime() > var_1.endtiredtime) {
    return level.success;
  }

  return level.running;
}

tired_end(var_0) {
  self.bforceallowpain = undefined;
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_1.endtiredtime = undefined;
  var_2 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  self.nextchargeattacktesttime = gettime() + randomintrange(var_2.min_charge_attack_interval_ms, var_2.max_charge_attack_interval_ms);
}

summon_begin(var_0) {
  scripts\asm\crab_brute\crab_brute_asm::setaction("summon");
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "summon", "summon");
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "summon");
}

summon_tick(var_0) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.success;
}

summon_end(var_0) {
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
  var_1 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  self.nextsummontesttime = gettime() + randomintrange(var_1.summon_min_interval_ms, var_1.summon_max_interval_ms);
  if(isDefined(self.nextflashtesttime) && self.nextflashtesttime < gettime() + var_1.flash_min_time_after_summon_ms) {
    self.nextflashtesttime = gettime() + var_1.flash_min_time_after_summon_ms;
  }
}

is_near_any_player(var_0) {
  var_1 = 90000;
  foreach(var_3 in level.players) {
    if(!isalive(var_3)) {
      continue;
    }

    if(var_3.ignoreme || isDefined(var_3.triggerportableradarping) && var_3.triggerportableradarping.ignoreme) {
      continue;
    }

    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_3)) {
      continue;
    }

    if(distancesquared(var_0, var_3.origin) < var_1) {
      return 1;
    }
  }

  return 0;
}

isnearanypointinarray(var_0, var_1, var_2) {
  foreach(var_4 in var_1) {
    var_5 = distancesquared(var_4, var_0);
    if(var_5 < var_2) {
      return 1;
    }
  }

  return 0;
}

isnearagents(var_0, var_1, var_2) {
  foreach(var_4 in var_1) {
    var_5 = distancesquared(var_4.origin, var_0);
    if(var_5 < var_2) {
      return 1;
    }
  }

  return 0;
}

calcsummonspawnpoints(var_0, var_1) {
  var_2 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_3 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  var_4 = [];
  if(isDefined(var_3)) {
    var_4 = getrandomnavpoints(var_3.origin, var_2.summon_max_radius, 64, self);
  } else {
    var_4 = getrandomnavpoints(self.origin, var_2.summon_max_radius, 64, self);
  }

  if(var_4.size == 0) {
    return undefined;
  }

  var_4 = scripts\engine\utility::array_randomize(var_4);
  var_5 = var_2.summon_min_radius * var_2.summon_min_radius;
  var_6 = [];
  foreach(var_8 in var_4) {
    var_9 = distancesquared(var_8, self.origin);
    if(var_9 < var_5) {
      continue;
    }

    if(is_near_any_player(var_8)) {
      continue;
    }

    if(isnearanypointinarray(var_8, var_6, var_2.summon_spawn_min_dist_between_agents_sq)) {
      continue;
    }

    if(isnearagents(var_8, var_1, var_2.summon_spawn_min_dist_between_agents_sq)) {
      continue;
    }

    var_6[var_6.size] = var_8;
    if(var_6.size >= var_0) {
      break;
    }
  }

  return var_6;
}

calcsummoncount(var_0) {
  var_1 = 0;
  foreach(var_3 in level.players) {
    if(scripts\mp\agents\crab_brute\crab_brute_agent::shouldignoreenemy(var_3)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_3.isfasttravelling)) {
      continue;
    }

    var_1 = var_1 + randomintrange(var_0.summon_min_spawn_num_per_player, var_0.summon_max_spawn_num_per_player);
  }

  var_5 = scripts\cp\zombies\cp_town_spawning::get_num_guys_to_brute_spawn();
  var_1 = min(var_5, var_1);
  return var_1;
}

trysummon(var_0, var_1, var_2) {
  if(!isDefined(level.crab_boss)) {
    return 0;
  }

  var_3 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  if(isDefined(var_1)) {
    if(var_1 < var_3.summon_min_dist_to_enemy_to_attempt_sq) {
      return 0;
    }
  }

  if(!scripts\engine\utility::istrue(var_2)) {
    if(isDefined(self.nextsummontesttime) && gettime() < self.nextsummontesttime) {
      return 0;
    }

    if(!isDefined(self.nextsummontesttime)) {
      self.nextsummontesttime = gettime() + randomintrange(var_3.min_initial_summon_wait_time_ms, var_3.max_initial_summon_wait_time_ms);
      return 0;
    }

    if(randomint(100) > var_3.summon_chance) {
      self.nextsummontesttime = gettime() + randomintrange(var_3.min_initial_summon_wait_time_ms, var_3.max_initial_summon_wait_time_ms);
      return 0;
    }
  }

  var_4 = scripts\mp\mp_agent::getactiveagentsoftype("crab_mini");
  if(var_4.size > var_3.max_allowed_minis_to_allow_new_summon) {
    self.nextsummontesttime = gettime() + randomintrange(var_3.min_initial_summon_wait_time_ms, var_3.max_initial_summon_wait_time_ms);
    return 0;
  }

  var_5 = calcsummoncount(var_3);
  if(var_5 <= 0) {
    self.nextsummontesttime = gettime() + 3000;
    return 0;
  }

  var_6 = calcsummonspawnpoints(var_5, var_4);
  if(var_6.size == 0) {
    self.nextsummontesttime = gettime() + 1000;
    return 0;
  }

  self.spawnpoints = var_6;
  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "summon");
  return 1;
}

taunt_begin(var_0) {
  scripts\asm\crab_brute\crab_brute_asm::setaction("taunt");
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "taunt", "taunt");
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "taunt");
}

taunt_tick(var_0) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.success;
}

taunt_end(var_0) {
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
}

trytaunt(var_0, var_1, var_2) {
  var_3 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  if(var_1 > var_3.max_dist_to_taunt_sq) {
    return 0;
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "taunt");
  return 1;
}

flash_begin(var_0) {
  scripts\asm\crab_brute\crab_brute_asm::setaction("flash");
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "flash", "flash");
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "flash");
}

flash_tick(var_0) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.success;
}

flash_end(var_0) {
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
  var_1 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  self.nextflashtesttime = gettime() + randomintrange(var_1.flash_min_interval_ms, var_1.flash_max_interval_ms);
  self.nextsummontesttime = gettime() + randomintrange(var_1.summon_min_interval_ms, var_1.summon_max_interval_ms);
  if(self.nextsummontesttime < gettime() + var_1.summon_min_time_after_flash_ms) {
    self.nextsummontesttime = gettime() + var_1.summon_min_time_after_flash_ms;
  }
}

tryflash(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_5 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_5)) {
    return 0;
  }

  if(isDefined(var_1)) {
    if(var_1 < var_4.flash_min_dist_to_enemy_to_attempt_sq) {
      return 0;
    }
  }

  if(!scripts\engine\utility::istrue(var_2)) {
    if(isDefined(self.nextflashtesttime) && gettime() < self.nextflashtesttime) {
      return 0;
    }

    if(!isDefined(self.nextflashtesttime)) {
      self.nextflashtesttime = gettime() + randomintrange(var_4.min_initial_flash_wait_time_ms, var_4.max_initial_flash_wait_time_ms);
      return 0;
    }

    if(randomint(100) > var_4.flash_chance) {
      self.nextflashtesttime = gettime() + randomintrange(var_4.min_initial_flash_wait_time_ms, var_4.max_initial_flash_wait_time_ms);
      return 0;
    }
  }

  if(!scripts\engine\utility::istrue(var_3)) {
    var_6 = var_5 getplayerangles();
    var_7 = anglesToForward(var_6);
    var_8 = vectornormalize(self.origin - var_5.origin);
    var_9 = vectordot(var_7, var_8);
    if(var_9 < var_4.flash_dot) {
      return 0;
    }
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "flash");
  return 1;
}

trymeleeattacks(var_0) {
  var_1 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  var_2 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  if(abs(var_1.origin[2] - self.origin[2]) > var_2.melee_max_z_diff) {
    return 0;
  }

  if(!isDefined(var_0)) {
    var_0 = distancesquared(self.origin, var_1.origin);
  }

  var_2 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  if(!ispointonnavmesh(var_1.origin)) {
    if(var_0 > self.meleeradiuswhentargetnotonnavmesh * self.meleeradiuswhentargetnotonnavmesh) {
      return 0;
    }
  } else if(var_0 > self.meleeradiusbasesq) {
    return 0;
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(0, "melee_attack");
  return 1;
}

decideaction(var_0) {
  var_1 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_1)) {
    return level.failure;
  }

  var_2 = gettime();
  var_3 = distancesquared(self.origin, var_1.origin);
  if(trymeleeattacks(var_3)) {
    return level.success;
  }

  if(self getpersstat(var_1)) {
    if(trycharge(var_0, var_3)) {
      return level.success;
    }

    if(isDefined(self.vehicle_getspawnerarray) && tryburrow(var_0, var_3)) {
      return level.success;
    }

    if(trysummon(var_0, var_3)) {
      return level.success;
    }

    if(tryflash(var_0, var_3)) {
      return level.success;
    }
  }

  return level.failure;
}

followenemy_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
}

followenemy_tick(var_0) {
  var_1 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_1)) {
    return level.failure;
  }

  var_2 = getclosestpointonnavmesh(var_1.origin, self);
  self ghostskulls_complete_status(var_2);
  return level.success;
}

followenemy_end(var_0) {
  self.bt.instancedata[var_0] = undefined;
}

findenemy_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
}

findenemy_tick(var_0) {
  return level.failure;
}

findenemy_end(var_0) {
  self.bt.instancedata[var_0] = undefined;
}