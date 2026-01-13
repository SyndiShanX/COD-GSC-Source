/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\aitypes\crab_mini\behaviors.gsc
***************************************************/

initbehaviors(var_0) {
  setupbehaviorstates();
  self.desiredaction = undefined;
  self.lastenemyengagetime = 0;
  self.myenemy = undefined;
  scripts\asm\asm_bb::bb_requestmovetype("sprint");
  return level.success;
}

setupbehaviorstates() {
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("stand_melee", ::melee_begin, ::melee_tick, ::melee_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("moving_melee", ::movingmelee_begin, ::movingmelee_tick, ::movingmelee_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("stuck", ::stuck_begin, ::stuck_tick, ::stuck_end);
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

shouldignoreenemy(var_0) {
  if(!isalive(var_0)) {
    return 1;
  }

  if(var_0.ignoreme || isDefined(var_0.triggerportableradarping) && var_0.triggerportableradarping.ignoreme) {
    return 1;
  }

  if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_0)) {
    return 1;
  }

  return 0;
}

updateenemy() {
  if(isDefined(self.myenemy) && !shouldignoreenemy(self.myenemy)) {
    if(gettime() - self.myenemystarttime < 3000) {
      return self.myenemy;
    }
  }

  var_0 = undefined;
  foreach(var_2 in level.players) {
    if(shouldignoreenemy(var_2)) {
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

stuck_begin(var_0) {
  var_1 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
  var_2 = randomintrange(var_1.stuck_min_time_ms, var_1.stuck_max_time_ms);
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "stuck", "stuck_loop", ::stuck_stopbeingstuck, undefined, var_2);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "stuck");
}

stuck_tick(var_0) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.success;
}

stuck_end(var_0) {
  scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(undefined);
  scripts\asm\crab_mini\crab_mini_asm::clearaction();
}

stuck_stopbeingstuck(var_0, var_1) {
  scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(undefined);
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "stuck_done", "stuck_exit", ::stuck_decideturn);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "stuck_done");
  return 1;
}

facepoint(var_0, var_1) {
  var_2 = scripts\engine\utility::getyawtospot(var_1);
  if(abs(var_2) < 22.5) {
    return;
  }

  self.desiredyaw = var_2;
}

stuck_decideturn(var_0, var_1) {
  var_2 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
  if(!isDefined(var_2)) {
    return 0;
  }

  var_3 = distancesquared(self.origin, var_2.origin);
  var_4 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
  if(var_3 < var_4.min_dist_to_enemy_to_allow_turn_sq) {
    return 0;
  }

  if(var_3 > var_4.max_dist_to_enemy_to_allow_turn_sq) {
    return 0;
  }

  if(!navisstraightlinereachable(self.origin, var_2.origin, self)) {
    return 0;
  }

  var_5 = scripts\engine\utility::getyawtospot(var_2.origin);
  if(abs(var_5) < 45) {
    return 0;
  }

  self.desiredyaw = var_5;
  return 1;
}

melee_begin(var_0) {
  var_1 = scripts\aitypes\dlc3\bt_action_api::getcurrentdesiredaction(var_0);
  scripts\asm\crab_mini\crab_mini_asm::setaction(var_1);
  var_2 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
  self.curmeleetarget = var_2;
  self.bmovingmelee = undefined;
  scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(undefined);
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
  scripts\asm\crab_mini\crab_mini_asm::clearaction();
  scripts\aitypes\dlc3\bt_state_api::btstate_endstates(var_0);
}

movingmelee_begin(var_0) {
  var_1 = scripts\aitypes\dlc3\bt_action_api::getcurrentdesiredaction(var_0);
  scripts\asm\crab_mini\crab_mini_asm::setaction(var_1);
  var_2 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
  self.curmeleetarget = var_2;
  self.bmovingmelee = 1;
  var_3 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_3.bfacingenemy = 1;
  scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(1);
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, var_1, var_1, ::movingmelee_attackdone);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, var_1);
}

movingmelee_tick(var_0) {
  self clearpath();
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.failure;
}

movingmelee_end(var_0) {
  self.curmeleetarget = undefined;
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_1.bfacingenemy = undefined;
  scripts\asm\crab_mini\crab_mini_asm::clearaction();
  scripts\aitypes\dlc3\bt_state_api::btstate_endstates(var_0);
}

movingmelee_attackdone(var_0, var_1) {
  if(scripts\mp\agents\crab_mini\crab_mini_agent::iscrabministuck()) {
    scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "stuck");
    return 0;
  }

  return 0;
}

getpredictedenemypos(var_0, var_1) {
  var_2 = var_0 getvelocity();
  var_3 = length2d(var_2);
  var_4 = var_0.origin + var_2 * var_1.avg_time_to_impact;
  return var_4;
}

trymeleeattacks(var_0) {
  var_1 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
  if(!isDefined(var_1)) {
    return level.failure;
  }

  var_2 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
  if(abs(var_1.origin[2] - self.origin[2]) > var_2.melee_max_z_diff) {
    return level.failure;
  }

  var_3 = var_1.origin;
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_3 = getpredictedenemypos(var_1, var_2);
  }

  var_4 = distancesquared(var_3, self.origin);
  if(var_4 < var_2.stand_melee_dist_sq) {
    scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "stand_melee");
    return 1;
  }

  var_5 = distancesquared(self.origin, var_1.origin);
  if(var_5 > var_2.non_predicted_move_melee_dist_sq) {
    if(var_4 > var_2.move_melee_dist_sq) {
      return 0;
    }
  }

  if(var_5 > var_2.check_reachable_dist_sq) {
    var_6 = self _meth_84AC();
    var_7 = getclosestpointonnavmesh(var_1.origin, self);
    if(!navisstraightlinereachable(var_6, var_7, self)) {
      return 0;
    }
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "moving_melee");
  return 1;
}

trymeleeattacks_old(var_0, var_1) {
  var_2 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
  if(!isDefined(var_1)) {
    var_1 = distancesquared(self.origin, var_2.origin);
  }

  var_3 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
  if(var_1 > var_3.move_melee_dist_sq) {
    return 0;
  }

  var_4 = var_2.origin - self.origin * (1, 1, 0);
  var_5 = anglesToForward(self.angles);
  var_6 = vectornormalize(var_4);
  var_7 = vectordot(var_5, var_6);
  if(var_7 < var_3.stand_melee_attack_dot) {
    return 0;
  }

  if(var_1 < var_3.stand_melee_dist_sq) {
    scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "stand_melee");
  } else {
    scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "moving_melee");
  }

  return 1;
}

decideaction(var_0) {
  var_1 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
  if(!isDefined(var_1)) {
    return level.failure;
  }

  var_2 = gettime();
  if(trymeleeattacks(var_0)) {
    self.lastenemyengagetime = var_2;
    return level.success;
  }

  return level.failure;
}

followenemy_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
}

followenemy_tick(var_0) {
  var_1 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
  if(!isDefined(var_1)) {
    return level.failure;
  }

  var_2 = getclosestpointonnavmesh(var_1.origin, self);
  self ghostskulls_complete_status(var_2);
  if(!self getpersstat(var_1)) {
    return level.running;
  }

  return level.success;
}

followenemy_end(var_0) {
  self.bt.instancedata[var_0] = undefined;
}