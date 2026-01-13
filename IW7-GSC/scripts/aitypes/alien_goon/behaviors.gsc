/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\alien_goon\behaviors.gsc
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
  scripts\aitypes\dlc4\simple_action::setupsimplebtaction();
  scripts\aitypes\dlc4\melee::setupstandmeleebtaction(undefined, ::melee_goontick);
  scripts\aitypes\dlc4\melee::setupmovingmeleebtaction(undefined, ::movingmelee_goontick);
  scripts\aitypes\dlc4\alien_jump::setupjumpattackbtaction();
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("teleport", ::teleport_begin, ::teleport_tick, ::teleport_end);
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("post_attack", ::postattack_begin, ::postattack_tick, ::postattack_end);
}

updateeveryframe(var_0) {
  scripts\aitypes\dlc4\behavior_utils::updateenemy();
  return level.failure;
}

teleport_begin(var_0) {
  scripts\aitypes\dlc4\behavior_utils::facepoint(self.var_AAFD);
  self._blackboard.jumpdestinationpos = self.var_AAFD;
  self._blackboard.jumpdestinationangles = vectortoangles(self.var_AAFD - self.origin * (1, 1, 0));
  self._blackboard.jumpnextpos = undefined;
  scripts\asm\dlc4\dlc4_asm::setasmaction("jump");
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "jump", "jump");
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "jump");
  self.bteleporting = 1;
}

teleport_tick(var_0) {
  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  self clearpath();
  return level.success;
}

teleport_end(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self.nextjumpattack = gettime() + var_1.jump_attack_min_interval;
  self._blackboard.jumpdestinationpos = undefined;
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
  self.bteleporting = undefined;
}

melee_goontick(var_0) {
  var_1 = scripts\aitypes\dlc4\melee::melee_tick(var_0);
  if(var_1 == level.failure) {
    scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "post_attack");
  }

  return var_1;
}

movingmelee_goontick(var_0) {
  var_1 = scripts\aitypes\dlc4\melee::movingmelee_tick(var_0);
  if(var_1 == level.failure) {
    scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "post_attack");
  }

  return var_1;
}

postattack_begin(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_2 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(var_0);
  var_2.postattackendtime = gettime() + var_1.min_time_between_melee_attacks_ms;
  var_3 = scripts\asm\dlc4\dlc4_asm::getenemy();
  if(!isDefined(var_3)) {
    scripts\asm\dlc4\dlc4_asm::setasmaction("taunt");
    scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "taunt", "taunt");
    scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "taunt");
    return;
  }

  var_4 = vectornormalize(var_3.origin - self.origin * (1, 1, 0));
  var_5 = anglesToForward(self.angles);
  var_6 = vectordot(var_4, var_5);
  var_7 = distancesquared(var_3.origin, self.origin);
  if(var_6 > 0 || var_7 < var_1.post_attack_max_enemy_dist_sq) {
    if(candomanuever("jump_back")) {
      scripts\asm\dlc4\dlc4_asm::setasmaction("jump_back");
      scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "jump_back", "jump_back");
      scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "jump_back");
      return;
    }

    if(candomanuever("slide_left")) {
      scripts\asm\dlc4\dlc4_asm::setasmaction("slide_left");
      scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "slide_left", "slide_left");
      scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "slide_left");
      return;
    }

    if(candomanuever("slide_right")) {
      scripts\asm\dlc4\dlc4_asm::setasmaction("slide_right");
      scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "slide_right", "slide_right");
      scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "slide_right");
      return;
    }
  }

  if(randomint(100) < var_1.post_attack_taunt_chance) {
    scripts\asm\dlc4\dlc4_asm::setasmaction("taunt");
    scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "taunt", "taunt");
    scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "taunt");
  }
}

postattack_tick(var_0) {
  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0)) {
    return level.runing;
  }

  var_1 = scripts\asm\dlc4\dlc4_asm::getenemy();
  if(!isDefined(var_1)) {
    return level.failure;
  }

  scripts\aitypes\dlc4\behavior_utils::facepoint(var_1.origin);
  var_2 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(var_0);
  if(gettime() < var_2.postattackendtime) {
    return level.running;
  }

  return level.success;
}

postattack_end(var_0) {
  var_1 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(var_0);
  var_1.postattackendtime = undefined;
}

candomanuever(var_0) {
  var_1 = self getsafecircleorigin(var_0, 0);
  var_2 = getmovedelta(var_1, 0, 1);
  var_3 = self gettweakablevalue(var_2);
  if(!scripts\mp\agents\zombie\zombie_util::func_38D1(self.origin, var_3)) {
    return 0;
  }

  return 1;
}

decideaction(var_0) {
  if(isDefined(self.desiredaction)) {
    return level.success;
  }

  if(isDefined(self.nextaction)) {
    scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, self.nextaction);
    self.nextaction = undefined;
    return level.success;
  }

  var_1 = scripts\asm\dlc4\dlc4_asm::getenemy();
  if(!isDefined(var_1)) {
    return level.failure;
  }

  var_2 = gettime();
  if(self getpersstat(var_1)) {
    if(scripts\aitypes\dlc4\melee::trymeleeattacks(var_0)) {
      self.lastenemyengagetime = var_2;
      return level.success;
    }

    if(scripts\aitypes\dlc4\alien_jump::tryjumpattack(var_0, var_1)) {
      return level.success;
    }
  } else {
    var_3 = scripts\asm\dlc4\dlc4_asm::gettunedata();
    var_4 = distancesquared(var_1.origin, self.origin);
    if(var_4 <= var_3.stand_melee_dist_sq) {
      if(scripts\aitypes\dlc4\melee::trymeleeattacks(var_0)) {
        self.lastenemyengagetime = var_2;
        return level.success;
      }
    }
  }

  return level.failure;
}

getdodgemovescale(var_0, var_1) {
  var_2 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_0, var_1);
  var_4 = self getsafecircleorigin(var_0, var_3);
  var_5 = scripts\mp\agents\_scriptedagents::getsafecircleradius(var_4);
  if(var_5 < var_2.min_dodge_scale) {
    return undefined;
  }

  if(var_5 > var_2.max_dodge_scale) {
    return var_2.max_dodge_scale;
  }

  return var_5;
}

updatestumble(var_0) {
  if(!isDefined(self.damageaccumulator)) {
    return 0;
  }

  if(isDefined(self._blackboard.requested_dodge_dir)) {
    return 0;
  }

  if(!isDefined(self.damageaccumulator.lastdamagetime) || gettime() > self.damageaccumulator.lastdamagetime + 1000) {
    self.damageaccumulator.accumulateddamage = 0;
    self.damageaccumulator.lastdamagetime = 0;
  }

  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  if(isDefined(self.nextstumbletime) && gettime() < self.nextstumbletime) {
    return 0;
  }

  if(self.damageaccumulator.accumulateddamage < self.maxhealth * var_1.stumble_damage_pct) {
    return 0;
  }

  if(randomint(100) < var_1.stumble_chance) {
    func_5AB8(var_0);
    return 1;
  }

  self.damageaccumulator.accumulateddamage = 0;
  self.damageaccumulator.lastdamagetime = 0;
  return 0;
}

updatedodge(var_0) {
  var_1 = gettime();
  if(isDefined(self._blackboard.requested_dodge_dir)) {
    if(self.lastdodgetime - var_1 > 150) {
      self._blackboard.requested_dodge_dir = undefined;
    } else {
      return 0;
    }
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(!isDefined(self.lastwhizbytime)) {
    return 0;
  }

  if(self.lastwhizbytime == var_1) {
    return 0;
  }

  var_2 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  if(var_1 - self.lastwhizbytime > 100) {
    self.lastwhizbytime = undefined;
    return 0;
  }

  if(isDefined(self.lastdodgechecktime) && var_1 - self.lastdodgechecktime < var_2.min_dodge_test_interval_ms) {
    return 0;
  }

  if(isDefined(self.lastdodgetime) && var_1 < self.lastdodgetime + var_2.min_dodge_interval_ms) {
    return 0;
  }

  self.lastdodgechecktime = var_1;
  var_3 = randomint(100);
  if(var_3 < var_2.dodge_chance) {
    var_4 = distancesquared(self.vehicle_getspawnerarray, self.origin);
    if(var_4 < var_2.min_enemy_dist_to_dodge_sq) {
      return 0;
    }

    self.lastdodgetime = gettime();
    var_5 = undefined;
    if(scripts\engine\utility::cointoss()) {
      var_6 = "left";
      var_5 = getdodgemovescale("run_dodge", var_6);
      if(!isDefined(var_5)) {
        var_6 = "right";
        var_5 = getdodgemovescale("run_dodge", var_6);
      }
    } else {
      var_6 = "right";
      var_5 = getdodgemovescale("run_dodge", var_6);
      if(!isDefined(var_5)) {
        var_6 = "left";
        var_5 = getdodgemovescale("run_dodge", var_6);
      }
    }

    if(isDefined(var_5)) {
      self._blackboard.requested_dodge_dir = var_6;
      self._blackboard.requested_dodge_scale = var_5;
      return 1;
    }
  }

  self.lastwhizbytime = undefined;
  return 0;
}

followenemy_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
}

followenemy_tick(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::getenemy();
  if(!isDefined(var_1)) {
    return level.failure;
  }

  if(!updatestumble(var_0)) {
    updatedodge(var_0);
  }

  var_2 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_3 = getclosestpointonnavmesh(var_1.origin, self);
  var_4 = distancesquared(var_3, self.origin);
  if(var_4 > var_2.stand_melee_dist_sq) {
    self ghostskulls_complete_status(var_3);
    if(!self getpersstat(var_1)) {
      if(!isDefined(self.vehicle_getspawnerarray)) {
        scripts\aitypes\dlc4\behavior_utils::facepoint(var_1.origin);
      }

      return level.running;
    }
  } else {
    scripts\aitypes\dlc4\behavior_utils::facepoint(var_1.origin);
  }

  return level.success;
}

followenemy_end(var_0) {
  self.bt.instancedata[var_0] = undefined;
}

jumpback(var_0) {
  scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(var_0, "jump_back");
}

slideleft(var_0) {
  scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(var_0, "slide_left");
}

slideright(var_0) {
  scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(var_0, "slide_right");
}

taunt(var_0) {
  scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(var_0, "taunt");
}

func_5AB8(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self.nextstumbletime = gettime() + var_1.stumble_interval_ms;
  scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(var_0, "stumble");
}