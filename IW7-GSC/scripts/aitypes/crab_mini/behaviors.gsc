/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\crab_mini\behaviors.gsc
***************************************************/

initbehaviors(param_00) {
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

shouldignoreenemy(param_00) {
  if(!isalive(param_00)) {
    return 1;
  }

  if(param_00.ignoreme || isDefined(param_00.triggerportableradarping) && param_00.triggerportableradarping.ignoreme) {
    return 1;
  }

  if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(param_00)) {
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

  var_00 = undefined;
  foreach(var_02 in level.players) {
    if(shouldignoreenemy(var_02)) {
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

stuck_begin(param_00) {
  var_01 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
  var_02 = randomintrange(var_01.stuck_min_time_ms, var_01.stuck_max_time_ms);
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "stuck", "stuck_loop", ::stuck_stopbeingstuck, undefined, var_02);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "stuck");
}

stuck_tick(param_00) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.success;
}

stuck_end(param_00) {
  scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(undefined);
  scripts\asm\crab_mini\crab_mini_asm::clearaction();
}

stuck_stopbeingstuck(param_00, param_01) {
  scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(undefined);
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "stuck_done", "stuck_exit", ::stuck_decideturn);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "stuck_done");
  return 1;
}

facepoint(param_00, param_01) {
  var_02 = scripts\engine\utility::getyawtospot(param_01);
  if(abs(var_02) < 22.5) {
    return;
  }

  self.desiredyaw = var_02;
}

stuck_decideturn(param_00, param_01) {
  var_02 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
  if(!isDefined(var_02)) {
    return 0;
  }

  var_03 = distancesquared(self.origin, var_02.origin);
  var_04 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
  if(var_03 < var_04.min_dist_to_enemy_to_allow_turn_sq) {
    return 0;
  }

  if(var_03 > var_04.max_dist_to_enemy_to_allow_turn_sq) {
    return 0;
  }

  if(!navisstraightlinereachable(self.origin, var_02.origin, self)) {
    return 0;
  }

  var_05 = scripts\engine\utility::getyawtospot(var_02.origin);
  if(abs(var_05) < 45) {
    return 0;
  }

  self.desiredyaw = var_05;
  return 1;
}

melee_begin(param_00) {
  var_01 = scripts\aitypes\dlc3\bt_action_api::getcurrentdesiredaction(param_00);
  scripts\asm\crab_mini\crab_mini_asm::setaction(var_01);
  var_02 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
  self.curmeleetarget = var_02;
  self.bmovingmelee = undefined;
  scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(undefined);
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
  scripts\asm\crab_mini\crab_mini_asm::clearaction();
  scripts\aitypes\dlc3\bt_state_api::btstate_endstates(param_00);
}

movingmelee_begin(param_00) {
  var_01 = scripts\aitypes\dlc3\bt_action_api::getcurrentdesiredaction(param_00);
  scripts\asm\crab_mini\crab_mini_asm::setaction(var_01);
  var_02 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
  self.curmeleetarget = var_02;
  self.bmovingmelee = 1;
  var_03 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_03.bfacingenemy = 1;
  scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(1);
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, var_01, var_01, ::movingmelee_attackdone);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, var_01);
}

movingmelee_tick(param_00) {
  self clearpath();
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.failure;
}

movingmelee_end(param_00) {
  self.curmeleetarget = undefined;
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_01.bfacingenemy = undefined;
  scripts\asm\crab_mini\crab_mini_asm::clearaction();
  scripts\aitypes\dlc3\bt_state_api::btstate_endstates(param_00);
}

movingmelee_attackdone(param_00, param_01) {
  if(scripts\mp\agents\crab_mini\crab_mini_agent::iscrabministuck()) {
    scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "stuck");
    return 0;
  }

  return 0;
}

getpredictedenemypos(param_00, param_01) {
  var_02 = param_00 getvelocity();
  var_03 = length2d(var_02);
  var_04 = param_00.origin + var_02 * param_01.avg_time_to_impact;
  return var_04;
}

trymeleeattacks(param_00) {
  var_01 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
  if(!isDefined(var_01)) {
    return level.failure;
  }

  var_02 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
  if(abs(var_01.origin[2] - self.origin[2]) > var_02.melee_max_z_diff) {
    return level.failure;
  }

  var_03 = var_01.origin;
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_03 = getpredictedenemypos(var_01, var_02);
  }

  var_04 = distancesquared(var_03, self.origin);
  if(var_04 < var_02.stand_melee_dist_sq) {
    scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "stand_melee");
    return 1;
  }

  var_05 = distancesquared(self.origin, var_01.origin);
  if(var_05 > var_02.non_predicted_move_melee_dist_sq) {
    if(var_04 > var_02.move_melee_dist_sq) {
      return 0;
    }
  }

  if(var_05 > var_02.check_reachable_dist_sq) {
    var_06 = self _meth_84AC();
    var_07 = getclosestpointonnavmesh(var_01.origin, self);
    if(!navisstraightlinereachable(var_06, var_07, self)) {
      return 0;
    }
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "moving_melee");
  return 1;
}

trymeleeattacks_old(param_00, param_01) {
  var_02 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
  if(!isDefined(param_01)) {
    param_01 = distancesquared(self.origin, var_02.origin);
  }

  var_03 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
  if(param_01 > var_03.move_melee_dist_sq) {
    return 0;
  }

  var_04 = var_02.origin - self.origin * (1, 1, 0);
  var_05 = anglesToForward(self.angles);
  var_06 = vectornormalize(var_04);
  var_07 = vectordot(var_05, var_06);
  if(var_07 < var_03.stand_melee_attack_dot) {
    return 0;
  }

  if(param_01 < var_03.stand_melee_dist_sq) {
    scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "stand_melee");
  } else {
    scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "moving_melee");
  }

  return 1;
}

decideaction(param_00) {
  var_01 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
  if(!isDefined(var_01)) {
    return level.failure;
  }

  var_02 = gettime();
  if(trymeleeattacks(param_00)) {
    self.lastenemyengagetime = var_02;
    return level.success;
  }

  return level.failure;
}

followenemy_begin(param_00) {
  self.var_3135.instancedata[param_00] = spawnStruct();
}

followenemy_tick(param_00) {
  var_01 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
  if(!isDefined(var_01)) {
    return level.failure;
  }

  var_02 = getclosestpointonnavmesh(var_01.origin, self);
  self ghostskulls_complete_status(var_02);
  if(!self getpersstat(var_01)) {
    return level.running;
  }

  return level.success;
}

followenemy_end(param_00) {
  self.var_3135.instancedata[param_00] = undefined;
}