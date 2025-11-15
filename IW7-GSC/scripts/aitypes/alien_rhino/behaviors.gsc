/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\alien_rhino\behaviors.gsc
*****************************************************/

initbehaviors(param_00) {
  setupbehaviorstates();
  self.desiredaction = undefined;
  self.lastenemyengagetime = 0;
  self.myenemy = undefined;
  scripts\asm\asm_bb::bb_requestmovetype("run");
  return level.success;
}

setupbehaviorstates() {
  scripts\aitypes\dlc4\simple_action::setupsimplebtaction();
  scripts\aitypes\dlc4\melee::setupstandmeleebtaction();
  scripts\aitypes\dlc4\melee::setupmovingmeleebtaction();
  scripts\aitypes\dlc4\alien_jump::setupjumpattackbtaction();
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("charge", ::charge_begin, ::charge_tick, ::charge_end);
}

updateeveryframe(param_00) {
  scripts\aitypes\dlc4\behavior_utils::updateenemy();
  return level.failure;
}

charge_begin(param_00) {
  scripts\asm\dlc4\dlc4_asm::setasmaction("charge");
  var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_02 = scripts\asm\dlc4\dlc4_asm::getenemy();
  self.curmeleetarget = var_02;
  self.bchargeaborted = undefined;
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00, "charge_intro", "charge_intro", ::charge_introdone);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00, "charge_intro");
}

charge_tick(param_00) {
  if(!isDefined(self.curmeleetarget) || scripts\aitypes\dlc4\behavior_utils::shouldignoreenemy(self.curmeleetarget)) {
    return level.failure;
  }

  if(scripts\engine\utility::istrue(self.bchargeaborted)) {
    return level.failure;
  }

  var_01 = getclosestpointonnavmesh(self.curmeleetarget.origin);
  self ghostskulls_complete_status(var_01);
  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.success;
}

charge_end(param_00) {
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
  self.curmeleetarget = undefined;
  self.bchargehit = undefined;
  self.desiredyaw = undefined;
  self.bchargeaborted = undefined;
  self.var_1198.chargeintroindex = undefined;
  self clearpath();
  var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self.nextchargeattacktesttime = gettime() + randomintrange(var_01.min_charge_attack_interval_ms, var_01.max_charge_attack_interval_ms);
}

charge_introdone(param_00, param_01) {
  var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00, "charging", "charge_loop", ::charge_movedone, undefined, var_02.max_charge_time_ms);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00, "charging");
  return 1;
}

charge_movedone(param_00, param_01) {
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00, "charge_end", "charge_outro", ::charge_enddone);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00, "charge_end");
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

  var_03 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_04 = scripts\asm\dlc4\dlc4_asm::getenemy();
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

  self.nextchargeattacktesttime = gettime() + 2000;
  var_05 = randomint(var_03.chargeintroanimtimes.size);
  var_06 = scripts\aitypes\dlc4\behavior_utils::getpredictedenemypos(var_04, var_03.chargeintroanimtimes[var_05] * 0.7);
  var_07 = anglesToForward(self.angles);
  var_08 = var_06 - self.origin;
  var_07 = (var_07[0], var_07[1], 0);
  var_08 = vectornormalize((var_08[0], var_08[1], 0));
  var_09 = vectordot(var_07, var_08);
  if(var_09 < 0.707) {
    return 0;
  }

  if(!navisstraightlinereachable(self.origin, var_06, self)) {
    self.nextchargeattacktesttime = gettime() + 500;
    return 0;
  }

  self.var_1198.chargeintroindex = var_05;
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00, "charge");
  return 1;
}

taunt(param_00) {
  scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(param_00, "taunt");
}

trytaunt(param_00) {
  var_01 = scripts\asm\dlc4\dlc4_asm::getenemy();
  if(!isDefined(var_01)) {
    return 0;
  }

  var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_03 = gettime();
  if(!isDefined(self.nexttaunttime)) {
    self.nexttaunttime = var_03 + var_02.initial_taunt_wait_time_ms;
    return 0;
  }

  if(var_03 < self.nexttaunttime) {
    return 0;
  }

  var_04 = distancesquared(self.origin, var_01.origin);
  if(var_04 < var_02.taunt_min_dist_to_enemy_sq) {
    self.nexttaunttime = var_03 + 1000;
    return 0;
  }

  if(var_04 > var_02.taunt_max_dist_to_enemy_sq) {
    self.nexttaunttime = var_03 + 1000;
    return 0;
  }

  self.nexttaunttime = var_03 + randomintrange(var_02.min_time_between_taunts_ms, var_02.max_time_between_taunts_ms);
  var_05 = randomint(var_02.taunt_chance);
  if(var_05 < var_02.taunt_chance) {
    taunt(param_00);
    return 1;
  }

  return 0;
}

decideaction(param_00) {
  if(isDefined(self.desiredaction)) {
    return level.success;
  }

  if(isDefined(self.nextaction)) {
    scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00, self.nextaction);
    self.nextaction = undefined;
    return level.success;
  }

  var_01 = scripts\asm\dlc4\dlc4_asm::getenemy();
  if(!isDefined(var_01)) {
    return level.failure;
  }

  var_02 = gettime();
  if(self getpersstat(var_01)) {
    if(scripts\aitypes\dlc4\melee::trymeleeattacks(param_00)) {
      self.lastenemyengagetime = var_02;
      return level.success;
    }

    if(trycharge(param_00)) {
      return level.success;
    }

    if(trytaunt(param_00)) {
      return level.success;
    }
  } else {
    var_03 = scripts\asm\dlc4\dlc4_asm::gettunedata();
    var_04 = distancesquared(var_01.origin, self.origin);
    if(var_04 <= var_03.stand_melee_dist_sq) {
      if(scripts\aitypes\dlc4\melee::trymeleeattacks(param_00)) {
        self.lastenemyengagetime = var_02;
        return level.success;
      }
    }
  }

  return level.failure;
}

followenemy_begin(param_00) {
  self.var_3135.instancedata[param_00] = spawnStruct();
}

followenemy_tick(param_00) {
  var_01 = scripts\asm\dlc4\dlc4_asm::getenemy();
  if(!isDefined(var_01)) {
    return level.failure;
  }

  var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_03 = getclosestpointonnavmesh(var_01.origin, self);
  var_04 = distancesquared(var_03, self.origin);
  if(var_04 > var_02.stand_melee_dist_sq) {
    self ghostskulls_complete_status(var_03);
    if(!self getpersstat(var_01)) {
      if(!isDefined(self.vehicle_getspawnerarray)) {
        scripts\aitypes\dlc4\behavior_utils::facepoint(var_01.origin);
      }

      return level.running;
    }
  } else {
    scripts\aitypes\dlc4\behavior_utils::facepoint(var_01.origin);
  }

  return level.success;
}

followenemy_end(param_00) {
  self.var_3135.instancedata[param_00] = undefined;
}