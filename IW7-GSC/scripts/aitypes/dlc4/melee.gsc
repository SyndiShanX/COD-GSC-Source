/******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\dlc4\melee.gsc
******************************************/

setupstandmeleebtaction(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = ::melee_begin;
  }

  if(!isDefined(param_01)) {
    param_01 = ::melee_tick;
  }

  if(!isDefined(param_02)) {
    param_02 = ::melee_end;
  }

  scripts\aitypes\dlc4\bt_action_api::setupbtaction("stand_melee", param_00, param_01, param_02);
}

setupmovingmeleebtaction(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = ::melee_begin;
  }

  if(!isDefined(param_01)) {
    param_01 = ::melee_tick;
  }

  if(!isDefined(param_02)) {
    param_02 = ::melee_end;
  }

  scripts\aitypes\dlc4\bt_action_api::setupbtaction("moving_melee", param_00, param_01, param_02);
}

melee_begin(param_00) {
  var_01 = scripts\aitypes\dlc4\bt_action_api::getcurrentdesiredbtaction(param_00);
  scripts\asm\dlc4\dlc4_asm::setasmaction(var_01);
  var_02 = scripts\asm\dlc4\dlc4_asm::getenemy();
  self.curmeleetarget = var_02;
  self.bmovingmelee = undefined;
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00, var_01, var_01);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00, var_01);
}

melee_tick(param_00) {
  self clearpath();
  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.failure;
}

melee_end(param_00) {
  self.curmeleetarget = undefined;
  self.var_A9B8 = gettime();
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
  scripts\aitypes\dlc4\bt_state_api::btstate_endstates(param_00);
}

movingmelee_begin(param_00) {
  var_01 = scripts\aitypes\dlc4\bt_action_api::getcurrentdesiredbtaction(param_00);
  scripts\asm\dlc4\dlc4_asm::setasmaction(var_01);
  var_02 = scripts\asm\dlc4\dlc4_asm::getenemy();
  self.curmeleetarget = var_02;
  self.bmovingmelee = 1;
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00, var_01, var_01, ::movingmelee_attackdone);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00, var_01);
}

movingmelee_tick(param_00) {
  self clearpath();
  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.failure;
}

movingmelee_end(param_00) {
  self.curmeleetarget = undefined;
  self.var_1198.movingmeleeattackindex = undefined;
  self.var_A9B8 = gettime();
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
  scripts\aitypes\dlc4\bt_state_api::btstate_endstates(param_00);
}

movingmelee_attackdone(param_00, param_01) {
  return 0;
}

trymeleeattacks(param_00) {
  var_01 = scripts\asm\dlc4\dlc4_asm::getenemy();
  if(!isDefined(var_01)) {
    return 0;
  }

  var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  if(isDefined(self.var_A9B8) && gettime() - self.var_A9B8 < var_02.min_time_between_melee_attacks_ms) {
    return 0;
  }

  if(abs(var_01.origin[2] - self.origin[2]) > var_02.melee_max_z_diff) {
    return 0;
  }

  var_03 = var_01.origin;
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_03 = scripts\aitypes\dlc4\behavior_utils::getpredictedenemypos(var_01, var_02.avg_time_to_impact);
  }

  var_04 = distancesquared(var_03, self.origin);
  if(var_04 < var_02.stand_melee_dist_sq) {
    scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00, "stand_melee");
    return 1;
  }

  var_05 = randomint(var_02.movingattackdisttoattacksq.size);
  var_06 = distancesquared(self.origin, var_01.origin);
  if(var_06 > var_02.non_predicted_move_melee_dist_sq) {
    if(var_04 > var_02.movingattackdisttoattacksq[var_05]) {
      return 0;
    }
  }

  if(var_06 > var_02.check_reachable_dist_sq) {
    var_07 = self _meth_84AC();
    var_08 = getclosestpointonnavmesh(var_01.origin, self);
    if(!navisstraightlinereachable(var_07, var_08, self)) {
      return 0;
    }
  }

  self.var_1198.movingmeleeattackindex = var_05;
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00, "moving_melee");
  return 1;
}