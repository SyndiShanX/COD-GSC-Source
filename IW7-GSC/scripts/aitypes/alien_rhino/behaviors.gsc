/*****************************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: scripts\aitypes\alien_rhino\behaviors.gsc
*****************************************************/

initbehaviors(var_0) {
  setupbehaviorstates();
  self.desiredaction = undefined;
  self.lastenemyengagetime = 0;
  self.myenemy = undefined;
  scripts\asm\asm_bb::bb_requestmovetype("run");
  return anim.success;
}

setupbehaviorstates() {
  scripts\aitypes\dlc4\simple_action::setupsimplebtaction();
  scripts\aitypes\dlc4\melee::setupstandmeleebtaction();
  scripts\aitypes\dlc4\melee::setupmovingmeleebtaction();
  scripts\aitypes\dlc4\alien_jump::setupjumpattackbtaction();
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("charge", ::charge_begin, ::charge_tick, ::charge_end);
}

updateeveryframe(var_0) {
  scripts\aitypes\dlc4\behavior_utils::updateenemy();
  return anim.failure;
}

charge_begin(var_0) {
  scripts\asm\dlc4\dlc4_asm::setasmaction("charge");
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_2 = scripts\asm\dlc4\dlc4_asm::getenemy();
  self.curmeleetarget = var_2;
  self.bchargeaborted = undefined;
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "charge_intro", "charge_intro", ::charge_introdone);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "charge_intro");
}

charge_tick(var_0) {
  if(!isDefined(self.curmeleetarget) || scripts\aitypes\dlc4\behavior_utils::shouldignoreenemy(self.curmeleetarget)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.bchargeaborted)) {
    return anim.failure;
  }

  var_1 = getclosestpointonnavmesh(self.curmeleetarget.origin);
  self scragentsetgoalpos(var_1);

  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0)) {
    return anim.running;
  }

  return anim.success;
}

charge_end(var_0) {
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
  self.curmeleetarget = undefined;
  self.bchargehit = undefined;
  self.desiredyaw = undefined;
  self.bchargeaborted = undefined;
  self._blackboard.chargeintroindex = undefined;
  self clearpath();
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self.nextchargeattacktesttime = gettime() + randomintrange(var_1.min_charge_attack_interval_ms, var_1.max_charge_attack_interval_ms);
}

charge_introdone(var_0, var_1) {
  var_2 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "charging", "charge_loop", ::charge_movedone, undefined, var_2.max_charge_time_ms);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "charging");
  return 1;
}

charge_movedone(var_0, var_1) {
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "charge_end", "charge_outro", ::charge_enddone);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "charge_end");
  return 1;
}

charge_enddone(var_0, var_1) {
  return 0;
}

trycharge(var_0, var_1, var_2) {
  if(!scripts\engine\utility::is_true(var_2)) {
    if(isDefined(self.nextchargeattacktesttime) && gettime() < self.nextchargeattacktesttime) {
      return 0;
    }
  }

  var_3 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_4 = scripts\asm\dlc4\dlc4_asm::getenemy();

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

  self.nextchargeattacktesttime = gettime() + 2000;
  var_5 = randomint(var_3.chargeintroanimtimes.size);
  var_6 = scripts\aitypes\dlc4\behavior_utils::getpredictedenemypos(var_4, var_3.chargeintroanimtimes[var_5] * 0.7);
  var_7 = anglesToForward(self.angles);
  var_8 = var_6 - self.origin;
  var_7 = (var_7[0], var_7[1], 0);
  var_8 = vectornormalize((var_8[0], var_8[1], 0));
  var_9 = vectordot(var_7, var_8);

  if(var_9 < 0.707) {
    return 0;
  }

  if(!func_2AC(self.origin, var_6, self)) {
    self.nextchargeattacktesttime = gettime() + 500;
    return 0;
  }

  self._blackboard.chargeintroindex = var_5;
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "charge");
  return 1;
}

taunt(var_0) {
  scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(var_0, "taunt");
}

trytaunt(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::getenemy();

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_3 = gettime();

  if(!isDefined(self.nexttaunttime)) {
    self.nexttaunttime = var_3 + var_2.initial_taunt_wait_time_ms;
    return 0;
  }

  if(var_3 < self.nexttaunttime) {
    return 0;
  }

  var_4 = distancesquared(self.origin, var_1.origin);

  if(var_4 < var_2.taunt_min_dist_to_enemy_sq) {
    self.nexttaunttime = var_3 + 1000;
    return 0;
  }

  if(var_4 > var_2.taunt_max_dist_to_enemy_sq) {
    self.nexttaunttime = var_3 + 1000;
    return 0;
  }

  self.nexttaunttime = var_3 + randomintrange(var_2.min_time_between_taunts_ms, var_2.max_time_between_taunts_ms);
  var_5 = randomint(var_2.taunt_chance);

  if(var_5 < var_2.taunt_chance) {
    taunt(var_0);
    return 1;
  }

  return 0;
}

decideaction(var_0) {
  if(isDefined(self.desiredaction)) {
    return anim.success;
  }

  if(isDefined(self.nextaction)) {
    scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, self.nextaction);
    self.nextaction = undefined;
    return anim.success;
  }

  var_1 = scripts\asm\dlc4\dlc4_asm::getenemy();

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  var_2 = gettime();

  if(self cansee(var_1)) {
    if(scripts\aitypes\dlc4\melee::trymeleeattacks(var_0)) {
      self.lastenemyengagetime = var_2;
      return anim.success;
    }

    if(trycharge(var_0)) {
      return anim.success;
    }

    if(trytaunt(var_0)) {
      return anim.success;
    }
  } else {
    var_3 = scripts\asm\dlc4\dlc4_asm::gettunedata();
    var_4 = distancesquared(var_1.origin, self.origin);

    if(var_4 <= var_3.stand_melee_dist_sq) {
      if(scripts\aitypes\dlc4\melee::trymeleeattacks(var_0)) {
        self.lastenemyengagetime = var_2;
        return anim.success;
      }
    }
  }

  return anim.failure;
}

followenemy_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
}

followenemy_tick(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::getenemy();

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  var_2 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_3 = getclosestpointonnavmesh(var_1.origin, self);
  var_4 = distancesquared(var_3, self.origin);

  if(var_4 > var_2.stand_melee_dist_sq) {
    self scragentsetgoalpos(var_3);

    if(!self cansee(var_1)) {
      if(!isDefined(self.pathgoalpos)) {
        scripts\aitypes\dlc4\behavior_utils::facepoint(var_1.origin);
      }

      return anim.running;
    }
  } else
    scripts\aitypes\dlc4\behavior_utils::facepoint(var_1.origin);

  return anim.success;
}

followenemy_end(var_0) {
  self.bt.instancedata[var_0] = undefined;
}