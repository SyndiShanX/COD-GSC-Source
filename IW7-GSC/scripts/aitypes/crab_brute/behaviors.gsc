/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\crab_brute\behaviors.gsc
****************************************************/

initbehaviors(param_00) {
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

pickbetterenemy(param_00, param_01) {
  var_02 = self getpersstat(param_00);
  var_03 = self getpersstat(param_01);
  if(var_02 != var_03) {
    if(var_02) {
      return param_00;
    }

    return param_01;
  }

  var_04 = distancesquared(self.origin, param_00.origin);
  var_05 = distancesquared(self.origin, param_01.origin);
  if(var_04 < var_05) {
    return param_00;
  }

  return param_01;
}

updateenemy() {
  if(isDefined(self.myenemy) && !scripts\mp\agents\crab_brute\crab_brute_agent::shouldignoreenemy(self.myenemy)) {
    if(gettime() - self.myenemystarttime < 3000) {
      return self.myenemy;
    }
  }

  var_00 = undefined;
  foreach(var_02 in level.players) {
    if(scripts\mp\agents\crab_brute\crab_brute_agent::shouldignoreenemy(var_02)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_02.isfasttravelling)) {
      continue;
    }

    if(!isDefined(var_00)) {
      var_00 = var_02;
      continue;
    }

    var_00 = pickbetterenemy(var_00, var_02);
  }

  if(!isDefined(var_00)) {
    self.myenemy = undefined;
    return undefined;
  }

  if(!isDefined(self.myenemy) || var_00 != self.myenemy) {
    self.myenemy = var_00;
    self.myenemystarttime = gettime();
  }
}

updateeveryframe(param_00) {
  updateenemy();
  return level.failure;
}

melee_begin(param_00) {
  var_01 = scripts\aitypes\dlc3\bt_action_api::getcurrentdesiredaction(param_00);
  scripts\asm\crab_brute\crab_brute_asm::setaction(var_01);
  var_02 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  var_03 = var_02 getvelocity();
  var_04 = length2dsquared(var_03);
  if(var_04 < 144) {
    self clearpath();
  } else {
    self.bmovingmelee = 1;
  }

  self.curmeleetarget = var_02;
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, var_01, var_01);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, var_01);
}

melee_tick(param_00) {
  self clearpath();
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.failure;
}

melee_end(param_00) {
  self.curmeleetarget = undefined;
  self.bmovingmelee = undefined;
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
  scripts\aitypes\dlc3\bt_state_api::btstate_endstates(param_00);
}

burrow_begin(param_00) {
  scripts\asm\crab_brute\crab_brute_asm::setaction("burrow");
  var_01 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_02 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(isDefined(var_02)) {
    var_03 = var_02.origin;
    if(isDefined(self.vehicle_getspawnerarray)) {
      var_03 = self getposonpath(32);
    }

    var_04 = scripts\engine\utility::getyawtospot(var_03);
    if(abs(var_04) > 45) {
      self.desiredyaw = var_04;
    }
  }

  var_05 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_06 = randomfloatrange(var_01.min_burrow_goal_radius, var_01.max_burrow_goal_radius);
  var_05.desiredradiussq = var_06 * var_06;
}

burrow_tick(param_00) {
  var_01 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  if(scripts\engine\utility::istrue(var_02.bburrowisdone)) {
    return level.success;
  }

  var_03 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_03)) {
    burrow_stop(param_00);
    return level.running;
  } else {
    var_04 = distancesquared(self.origin, var_03.origin);
    if(var_04 < var_02.desiredradiussq) {
      burrow_stop(param_00);
      return level.running;
    }
  }

  var_05 = self getvelocity() * (1, 1, 0);
  var_06 = self getposonpath(length2d(var_05) * var_01.burrow_look_ahead_time);
  var_07 = var_06 + (0, 0, 40);
  var_08 = var_06 - (0, 0, 60);
  var_09 = scripts\common\trace::ray_trace(var_07, var_08, self, undefined, 1, 1);
  if(isDefined(var_09)) {
    var_0A = var_09["surfacetype"];
    if(!isvalidburrowsurface(var_0A)) {
      burrow_stop(param_00);
      return level.running;
    }
  }

  var_0B = getclosestpointonnavmesh(var_03.origin, self);
  self ghostskulls_complete_status(var_0B);
  return level.running;
}

burrow_end(param_00) {
  self.desiredyaw = undefined;
  self clearpath();
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
}

burrow_stop(param_00) {
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_01.bburrowisdone = undefined;
  var_01.desiredradiussq = undefined;
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "burrow_popup", "burrow_outro", ::burrow_outro_done, undefined, undefined, 1000);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "burrow_popup");
}

burrow_outro_done(param_00, param_01) {
  var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_02.bburrowisdone = 1;
  var_03 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_04 = 0;
  var_04 = var_04 + var_03.post_burrow_charge_chance;
  var_04 = var_04 + var_03.post_burrow_taunt_chance;
  var_04 = var_04 + var_03.post_burrow_flash_chance;
  var_04 = var_04 + var_03.post_burrow_summon_chance;
  var_04 = var_04 + var_03.post_burrow_nothing_chance;
  var_05 = randomint(var_04);
  var_06 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_06)) {
    return 0;
  }

  var_07 = distancesquared(var_06.origin, self.origin);
  if(trymeleeattacks(var_07)) {
    return 0;
  }

  if(var_05 < var_03.post_burrow_charge_chance) {
    if(trycharge(param_00, var_07, 1)) {
      return 0;
    }
  }

  var_05 = var_05 - var_03.post_burrow_charge_chance;
  if(var_05 < var_03.post_burrow_flash_chance) {
    if(tryflash(param_00, var_07, 1)) {
      return 0;
    }
  }

  var_05 = var_05 - var_03.post_burrow_charge_chance;
  if(var_05 < var_03.post_burrow_flash_chance) {
    if(trysummon(param_00, var_07, 1)) {
      return 0;
    }
  }

  var_05 = var_05 - var_03.post_burrow_taunt_chance;
  if(var_05 < var_03.post_burrow_taunt_chance) {
    if(trytaunt(param_00, var_07, 1)) {
      return 0;
    }
  }

  return 0;
}

isvalidburrowsurface(param_00) {
  switch (param_00) {
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
  var_00 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_01 = sqrt(var_00.burrow_mindist_sq) + var_00.max_burrow_goal_radius;
  var_02 = 0;
  for(var_03 = undefined; var_02 < var_01; var_03 = var_04) {
    var_04 = self getposonpath(var_02);
    if(isDefined(var_03) && distance2dsquared(var_03, var_04) < 64) {
      return 0;
    }

    var_05 = var_04 + (0, 0, 40);
    var_06 = var_04 - (0, 0, 60);
    var_07 = scripts\common\trace::ray_trace(var_05, var_06, self, undefined, 1, 1);
    var_08 = var_07["surfacetype"];
    if(!isvalidburrowsurface(var_08)) {
      return 0;
    }

    var_02 = var_02 + var_00.burrow_path_check_interval_dist;
  }

  return 1;
}

tryburrow(param_00, param_01) {
  if(isDefined(self.nextburrowtesttime) && gettime() < self.nextburrowtesttime) {
    return 0;
  }

  var_02 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  if(!isDefined(self.nextburrowtesttime)) {
    self.nextburrowtesttime = gettime() + var_02.initial_burrow_wait_time_ms;
  }

  self.nextburrowtesttime = gettime() + 500;
  var_03 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_03)) {
    return 0;
  }

  if(!isDefined(param_01)) {
    param_01 = distancesquared(var_03.origin, self.origin);
  }

  if(param_01 < var_02.burrow_mindist_sq) {
    return 0;
  }

  if(param_01 > var_02.burrow_maxdist_sq) {
    return 0;
  }

  var_04 = scripts\common\trace::ray_trace(self.origin + (0, 0, 40), self.origin - (0, 0, 40), self, undefined, 1, 1);
  if(!isDefined(var_04)) {
    return 0;
  }

  var_05 = var_04["surfacetype"];
  if(!isvalidburrowsurface(var_05)) {
    return 0;
  }

  if(isDefined(self.vehicle_getspawnerarray)) {
    if(!isvalidburrowpath()) {
      self.nextburrowtesttime = gettime() + 1500;
      return 0;
    }
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "burrow");
  return 1;
}

charge_begin(param_00) {
  scripts\asm\crab_brute\crab_brute_asm::setaction("charge");
  var_01 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_02 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  self.curmeleetarget = var_02;
  if(isDefined(var_02)) {
    var_03 = scripts\engine\utility::getyawtospot(var_02.origin);
    if(abs(var_03) > 45) {
      self.desiredyaw = var_03;
    }
  }

  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "charging", "charge_loop", ::charge_movedone, undefined, var_01.max_charge_time_ms, 2000);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "charging");
}

charge_tick(param_00) {
  if(!isDefined(self.curmeleetarget) || scripts\mp\agents\crab_brute\crab_brute_agent::shouldignoreenemy(self.curmeleetarget)) {
    return level.failure;
  }

  self ghostskulls_complete_status(self.curmeleetarget.origin);
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  var_01 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(isDefined(var_01)) {
    var_02 = distancesquared(var_01.origin, self.origin);
    if(trymeleeattacks(var_02)) {
      return level.success;
    }

    if(trysummon(param_00, 1409865409, 1)) {
      return level.success;
    }

    if(tryflash(param_00, 1409865409, 1, 1)) {
      return level.success;
    }

    scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "taunt");
  }

  return level.success;
}

charge_end(param_00) {
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
  self.curmeleetarget = undefined;
  self.bchargehit = undefined;
  self.desiredyaw = undefined;
  self clearpath();
  var_01 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  self.nextchargeattacktesttime = gettime() + randomintrange(var_01.min_charge_attack_interval_ms, var_01.max_charge_attack_interval_ms);
}

charge_movedone(param_00, param_01) {
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "charge_end", "charge_outro", ::charge_enddone);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "charge_end");
  return 1;
}

charge_enddone(param_00, param_01) {
  return 0;
}

trycharge(param_00, param_01, param_02) {
  if(!scripts\engine\utility::istrue(param_02)) {
    if(isDefined(self.nextchargeattacktesttime) && gettime() < self.nextchargeattacktesttime) {
      return 0;
    }
  }

  var_03 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_04 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_04)) {
    return 0;
  }

  if(!isDefined(param_01)) {
    param_01 = distancesquared(var_04.origin, self.origin);
  }

  if(param_01 < var_03.charge_attack_mindist_sq) {
    return 0;
  }

  if(param_01 > var_03.charge_attack_maxdist_sq) {
    return 0;
  }

  self.nextchargeattacktesttime = gettime() + 5000;
  var_05 = anglesToForward(self.angles);
  var_06 = var_04.origin;
  var_07 = var_06 - self.origin;
  var_05 = (var_05[0], var_05[1], 0);
  var_07 = vectornormalize((var_07[0], var_07[1], 0));
  var_08 = vectordot(var_05, var_07);
  if(var_08 < 0.707) {
    return 0;
  }

  if(!navisstraightlinereachable(self.origin, var_06, self)) {
    self.nextchargeattacktesttime = gettime() + 500;
    return 0;
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "charge");
  return 1;
}

tired_begin(param_00) {
  self clearpath();
  self.bforceallowpain = 1;
  scripts\asm\crab_brute\crab_brute_asm::setaction("tired");
  var_01 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_02.endtiredtime = gettime() + randomintrange(var_01.min_tired_time_ms, var_01.max_tired_time_ms);
}

tired_tick(param_00) {
  self clearpath();
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  if(gettime() > var_01.endtiredtime) {
    return level.success;
  }

  return level.running;
}

tired_end(param_00) {
  self.bforceallowpain = undefined;
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_01.endtiredtime = undefined;
  var_02 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  self.nextchargeattacktesttime = gettime() + randomintrange(var_02.min_charge_attack_interval_ms, var_02.max_charge_attack_interval_ms);
}

summon_begin(param_00) {
  scripts\asm\crab_brute\crab_brute_asm::setaction("summon");
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "summon", "summon");
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "summon");
}

summon_tick(param_00) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.success;
}

summon_end(param_00) {
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
  var_01 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  self.nextsummontesttime = gettime() + randomintrange(var_01.summon_min_interval_ms, var_01.summon_max_interval_ms);
  if(isDefined(self.nextflashtesttime) && self.nextflashtesttime < gettime() + var_01.flash_min_time_after_summon_ms) {
    self.nextflashtesttime = gettime() + var_01.flash_min_time_after_summon_ms;
  }
}

is_near_any_player(param_00) {
  var_01 = 90000;
  foreach(var_03 in level.players) {
    if(!isalive(var_03)) {
      continue;
    }

    if(var_03.ignoreme || isDefined(var_03.triggerportableradarping) && var_03.triggerportableradarping.ignoreme) {
      continue;
    }

    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_03)) {
      continue;
    }

    if(distancesquared(param_00, var_03.origin) < var_01) {
      return 1;
    }
  }

  return 0;
}

isnearanypointinarray(param_00, param_01, param_02) {
  foreach(var_04 in param_01) {
    var_05 = distancesquared(var_04, param_00);
    if(var_05 < param_02) {
      return 1;
    }
  }

  return 0;
}

isnearagents(param_00, param_01, param_02) {
  foreach(var_04 in param_01) {
    var_05 = distancesquared(var_04.origin, param_00);
    if(var_05 < param_02) {
      return 1;
    }
  }

  return 0;
}

calcsummonspawnpoints(param_00, param_01) {
  var_02 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_03 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  var_04 = [];
  if(isDefined(var_03)) {
    var_04 = getrandomnavpoints(var_03.origin, var_02.summon_max_radius, 64, self);
  } else {
    var_04 = getrandomnavpoints(self.origin, var_02.summon_max_radius, 64, self);
  }

  if(var_04.size == 0) {
    return undefined;
  }

  var_04 = scripts\engine\utility::array_randomize(var_04);
  var_05 = var_02.summon_min_radius * var_02.summon_min_radius;
  var_06 = [];
  foreach(var_08 in var_04) {
    var_09 = distancesquared(var_08, self.origin);
    if(var_09 < var_05) {
      continue;
    }

    if(is_near_any_player(var_08)) {
      continue;
    }

    if(isnearanypointinarray(var_08, var_06, var_02.summon_spawn_min_dist_between_agents_sq)) {
      continue;
    }

    if(isnearagents(var_08, param_01, var_02.summon_spawn_min_dist_between_agents_sq)) {
      continue;
    }

    var_06[var_06.size] = var_08;
    if(var_06.size >= param_00) {
      break;
    }
  }

  return var_06;
}

calcsummoncount(param_00) {
  var_01 = 0;
  foreach(var_03 in level.players) {
    if(scripts\mp\agents\crab_brute\crab_brute_agent::shouldignoreenemy(var_03)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_03.isfasttravelling)) {
      continue;
    }

    var_01 = var_01 + randomintrange(param_00.summon_min_spawn_num_per_player, param_00.summon_max_spawn_num_per_player);
  }

  var_05 = scripts\cp\zombies\cp_town_spawning::get_num_guys_to_brute_spawn();
  var_01 = min(var_05, var_01);
  return var_01;
}

trysummon(param_00, param_01, param_02) {
  if(!isDefined(level.crab_boss)) {
    return 0;
  }

  var_03 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  if(isDefined(param_01)) {
    if(param_01 < var_03.summon_min_dist_to_enemy_to_attempt_sq) {
      return 0;
    }
  }

  if(!scripts\engine\utility::istrue(param_02)) {
    if(isDefined(self.nextsummontesttime) && gettime() < self.nextsummontesttime) {
      return 0;
    }

    if(!isDefined(self.nextsummontesttime)) {
      self.nextsummontesttime = gettime() + randomintrange(var_03.min_initial_summon_wait_time_ms, var_03.max_initial_summon_wait_time_ms);
      return 0;
    }

    if(randomint(100) > var_03.summon_chance) {
      self.nextsummontesttime = gettime() + randomintrange(var_03.min_initial_summon_wait_time_ms, var_03.max_initial_summon_wait_time_ms);
      return 0;
    }
  }

  var_04 = scripts\mp\mp_agent::getactiveagentsoftype("crab_mini");
  if(var_04.size > var_03.max_allowed_minis_to_allow_new_summon) {
    self.nextsummontesttime = gettime() + randomintrange(var_03.min_initial_summon_wait_time_ms, var_03.max_initial_summon_wait_time_ms);
    return 0;
  }

  var_05 = calcsummoncount(var_03);
  if(var_05 <= 0) {
    self.nextsummontesttime = gettime() + 3000;
    return 0;
  }

  var_06 = calcsummonspawnpoints(var_05, var_04);
  if(var_06.size == 0) {
    self.nextsummontesttime = gettime() + 1000;
    return 0;
  }

  self.spawnpoints = var_06;
  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "summon");
  return 1;
}

taunt_begin(param_00) {
  scripts\asm\crab_brute\crab_brute_asm::setaction("taunt");
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "taunt", "taunt");
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "taunt");
}

taunt_tick(param_00) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.success;
}

taunt_end(param_00) {
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
}

trytaunt(param_00, param_01, param_02) {
  var_03 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  if(param_01 > var_03.max_dist_to_taunt_sq) {
    return 0;
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "taunt");
  return 1;
}

flash_begin(param_00) {
  scripts\asm\crab_brute\crab_brute_asm::setaction("flash");
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "flash", "flash");
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "flash");
}

flash_tick(param_00) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.success;
}

flash_end(param_00) {
  scripts\asm\crab_brute\crab_brute_asm::clearaction();
  var_01 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  self.nextflashtesttime = gettime() + randomintrange(var_01.flash_min_interval_ms, var_01.flash_max_interval_ms);
  self.nextsummontesttime = gettime() + randomintrange(var_01.summon_min_interval_ms, var_01.summon_max_interval_ms);
  if(self.nextsummontesttime < gettime() + var_01.summon_min_time_after_flash_ms) {
    self.nextsummontesttime = gettime() + var_01.summon_min_time_after_flash_ms;
  }
}

tryflash(param_00, param_01, param_02, param_03) {
  var_04 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_05 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_05)) {
    return 0;
  }

  if(isDefined(param_01)) {
    if(param_01 < var_04.flash_min_dist_to_enemy_to_attempt_sq) {
      return 0;
    }
  }

  if(!scripts\engine\utility::istrue(param_02)) {
    if(isDefined(self.nextflashtesttime) && gettime() < self.nextflashtesttime) {
      return 0;
    }

    if(!isDefined(self.nextflashtesttime)) {
      self.nextflashtesttime = gettime() + randomintrange(var_04.min_initial_flash_wait_time_ms, var_04.max_initial_flash_wait_time_ms);
      return 0;
    }

    if(randomint(100) > var_04.flash_chance) {
      self.nextflashtesttime = gettime() + randomintrange(var_04.min_initial_flash_wait_time_ms, var_04.max_initial_flash_wait_time_ms);
      return 0;
    }
  }

  if(!scripts\engine\utility::istrue(param_03)) {
    var_06 = var_05 getplayerangles();
    var_07 = anglesToForward(var_06);
    var_08 = vectornormalize(self.origin - var_05.origin);
    var_09 = vectordot(var_07, var_08);
    if(var_09 < var_04.flash_dot) {
      return 0;
    }
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "flash");
  return 1;
}

trymeleeattacks(param_00) {
  var_01 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  var_02 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  if(abs(var_01.origin[2] - self.origin[2]) > var_02.melee_max_z_diff) {
    return 0;
  }

  if(!isDefined(param_00)) {
    param_00 = distancesquared(self.origin, var_01.origin);
  }

  var_02 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  if(!ispointonnavmesh(var_01.origin)) {
    if(param_00 > self.meleeradiuswhentargetnotonnavmesh * self.meleeradiuswhentargetnotonnavmesh) {
      return 0;
    }
  } else if(param_00 > self.meleeradiusbasesq) {
    return 0;
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(0, "melee_attack");
  return 1;
}

decideaction(param_00) {
  var_01 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_01)) {
    return level.failure;
  }

  var_02 = gettime();
  var_03 = distancesquared(self.origin, var_01.origin);
  if(trymeleeattacks(var_03)) {
    return level.success;
  }

  if(self getpersstat(var_01)) {
    if(trycharge(param_00, var_03)) {
      return level.success;
    }

    if(isDefined(self.vehicle_getspawnerarray) && tryburrow(param_00, var_03)) {
      return level.success;
    }

    if(trysummon(param_00, var_03)) {
      return level.success;
    }

    if(tryflash(param_00, var_03)) {
      return level.success;
    }
  } else {}

  return level.failure;
}

followenemy_begin(param_00) {
  self.var_3135.instancedata[param_00] = spawnStruct();
}

followenemy_tick(param_00) {
  var_01 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_01)) {
    return level.failure;
  }

  var_02 = getclosestpointonnavmesh(var_01.origin, self);
  self ghostskulls_complete_status(var_02);
  return level.success;
}

followenemy_end(param_00) {
  self.var_3135.instancedata[param_00] = undefined;
}

findenemy_begin(param_00) {
  self.var_3135.instancedata[param_00] = spawnStruct();
}

findenemy_tick(param_00) {
  return level.failure;
}

findenemy_end(param_00) {
  self.var_3135.instancedata[param_00] = undefined;
}