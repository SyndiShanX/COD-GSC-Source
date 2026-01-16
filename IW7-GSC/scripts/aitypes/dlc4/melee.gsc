/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: scripts\aitypes\dlc4\melee.gsc
***********************************************/

setupstandmeleebtaction(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = ::melee_begin;
  }

  if(!isDefined(var_1)) {
    var_1 = ::melee_tick;
  }

  if(!isDefined(var_2)) {
    var_2 = ::melee_end;
  }

  scripts\aitypes\dlc4\bt_action_api::setupbtaction("stand_melee", var_0, var_1, var_2);
}

setupmovingmeleebtaction(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = ::melee_begin;
  }

  if(!isDefined(var_1)) {
    var_1 = ::melee_tick;
  }

  if(!isDefined(var_2)) {
    var_2 = ::melee_end;
  }

  scripts\aitypes\dlc4\bt_action_api::setupbtaction("moving_melee", var_0, var_1, var_2);
}

melee_begin(var_0) {
  var_1 = scripts\aitypes\dlc4\bt_action_api::getcurrentdesiredbtaction(var_0);
  scripts\asm\dlc4\dlc4_asm::setasmaction(var_1);
  var_2 = scripts\asm\dlc4\dlc4_asm::getenemy();
  self.curmeleetarget = var_2;
  self.bmovingmelee = undefined;
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, var_1, var_1);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, var_1);
}

melee_tick(var_0) {
  self clearpath();

  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0)) {
    return anim.running;
  }

  return anim.failure;
}

melee_end(var_0) {
  self.curmeleetarget = undefined;
  self.var_A9B8 = gettime();
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
  scripts\aitypes\dlc4\bt_state_api::btstate_endstates(var_0);
}

movingmelee_begin(var_0) {
  var_1 = scripts\aitypes\dlc4\bt_action_api::getcurrentdesiredbtaction(var_0);
  scripts\asm\dlc4\dlc4_asm::setasmaction(var_1);
  var_2 = scripts\asm\dlc4\dlc4_asm::getenemy();
  self.curmeleetarget = var_2;
  self.bmovingmelee = 1;
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, var_1, var_1, ::movingmelee_attackdone);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, var_1);
}

movingmelee_tick(var_0) {
  self clearpath();

  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0)) {
    return anim.running;
  }

  return anim.failure;
}

movingmelee_end(var_0) {
  self.curmeleetarget = undefined;
  self._blackboard.movingmeleeattackindex = undefined;
  self.var_A9B8 = gettime();
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
  scripts\aitypes\dlc4\bt_state_api::btstate_endstates(var_0);
}

movingmelee_attackdone(var_0, var_1) {
  return 0;
}

trymeleeattacks(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::getenemy();

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = scripts\asm\dlc4\dlc4_asm::gettunedata();

  if(isDefined(self.var_A9B8) && gettime() - self.var_A9B8 < var_2.min_time_between_melee_attacks_ms) {
    return 0;
  }

  if(abs(var_1.origin[2] - self.origin[2]) > var_2.melee_max_z_diff) {
    return 0;
  }

  var_3 = var_1.origin;

  if(isDefined(self.pathgoalpos)) {
    var_3 = scripts\aitypes\dlc4\behavior_utils::getpredictedenemypos(var_1, var_2.avg_time_to_impact);
  }

  var_4 = distancesquared(var_3, self.origin);

  if(var_4 < var_2.stand_melee_dist_sq) {
    scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "stand_melee");
    return 1;
  }

  var_5 = randomint(var_2.movingattackdisttoattacksq.size);
  var_6 = distancesquared(self.origin, var_1.origin);

  if(var_6 > var_2.non_predicted_move_melee_dist_sq) {
    if(var_4 > var_2.movingattackdisttoattacksq[var_5]) {
      return 0;
    }
  }

  if(var_6 > var_2.check_reachable_dist_sq) {
    var_7 = self func_84AC();
    var_8 = getclosestpointonnavmesh(var_1.origin, self);

    if(!func_2AC(var_7, var_8, self)) {
      return 0;
    }
  }

  self._blackboard.movingmeleeattackindex = var_5;
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "moving_melee");
  return 1;
}