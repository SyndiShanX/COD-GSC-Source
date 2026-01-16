/*************************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: scripts\aitypes\slasher\behaviors.gsc
*************************************************/

initslasher(var_0) {
  setupslasherstates();
  self.desiredaction = undefined;
  self.lastenemysighttime = 0;
  self.lastenemyengagetime = 0;
  self.slasherenemy = undefined;
  self.slasherenemystarttime = 0;
  self.last_health = self.health;
  return anim.success;
}

setupslasheraction(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.fnbegin = var_1;
  var_4.fntick = var_2;
  var_4.fnend = var_3;

  if(!isDefined(self.actions)) {
    self.actions = [];
  }

  self.actions[var_0] = var_4;
}

setupslasherstates() {
  scripts\aitypes\slasher\bt_state_api::btstate_setupstate("aim", ::sawbladeattack_aim_begin, ::sawbladeattack_aim_tick, ::sawbladeattack_aim_end);
  scripts\aitypes\slasher\bt_state_api::btstate_setupstate("shoot", ::sawbladeattack_shoot_begin, ::sawbladeattack_shoot_tick, ::sawbladeattack_shoot_end);
  setupslasheraction("sawblade_attack", ::sawbladeattack_begin, ::sawbladeattack_tick, ::sawbladeattack_end);
  setupslasheraction("ground_pound", ::groundpoundattack_begin, ::groundpoundattack_tick, ::groundpoundattack_end);
  setupslasheraction("ram_attack", ::ramattack_begin, ::ramattack_tick, ::ramattack_end);
  setupslasheraction("taunt", ::taunt_begin, ::taunt_tick, ::taunt_end);
  setupslasheraction("teleport", ::teleport_begin, ::teleport_tick, ::teleport_end);
  setupslasheraction("summon", ::summon_begin, ::summon_tick, ::summon_end);
  setupslasheraction("block", ::block_begin, ::block_tick, ::block_end);
  setupslasheraction("swipe_attack", ::melee_begin, ::melee_tick, ::melee_end);
  setupslasheraction("melee_spin", ::melee_begin, ::melee_tick, ::melee_end);
  setupslasheraction("grenade_throw", ::grenadethrow_begin, ::grenadethrow_tick, ::grenadethrow_end);
  setupslasheraction("debug_handler", ::debughandler_begin, ::debughandler_tick, ::debughandler_end);
}

pickbetterenemy(var_0, var_1) {
  if(isDefined(self.slasherenemy)) {
    if(var_0 == self.slasherenemy) {
      if(gettime() - self.slasherenemystarttime < 3000) {
        return var_0;
      }
    } else if(var_1 == self.slasherenemy) {
      if(gettime() - self.slasherenemystarttime < 3000) {
        return var_1;
      }
    }
  }

  var_2 = self cansee(var_0);
  var_3 = self cansee(var_1);

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
  var_0 = undefined;
  var_1 = self isethereal();

  foreach(var_3 in level.players) {
    if(!isalive(var_3)) {
      continue;
    }
    if(var_3.ignoreme || isDefined(var_3.owner) && var_3.owner.ignoreme) {
      continue;
    }
    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_3)) {
      continue;
    }
    if(var_1 && !var_3 func_85BA()) {
      continue;
    }
    if(!isDefined(var_0)) {
      var_0 = var_3;
      continue;
    }

    var_0 = pickbetterenemy(var_0, var_3);
  }

  if(!isDefined(var_0)) {
    self.slasherenemy = undefined;
    return undefined;
  }

  if(!isDefined(self.slasherenemy) || var_0 != self.slasherenemy) {
    self.slasherenemy = var_0;
    self.slasherenemystarttime = gettime();
  }

  return self.slasherenemy;
}

updateslashereveryframe(var_0) {
  var_1 = updateenemy();

  if(isDefined(var_1)) {
    if(self cansee(var_1)) {
      self.lastenemysighttime = gettime();
      self.lastenemysightpos = var_1.origin;

      if(!isDefined(self.enemyreacquiredtime)) {
        self.enemyreacquiredtime = self.lastenemysighttime;
      }
    } else
      self.enemyreacquiredtime = undefined;
  } else {
    self.lastenemysighttime = 0;
    self.lastenemysightpos = undefined;
    self.enemyreacquiredtime = undefined;
  }

  return anim.failure;
}

getcurrentdesiredaction(var_0) {
  return self.bt.instancedata[var_0].slasheraction;
}

calcenemytargetpos(var_0, var_1) {
  var_2 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  var_3 = var_2 getvelocity();
  var_4 = distance(var_2.origin, self.origin);
  var_5 = var_4 / 1500;
  var_6 = var_2 getshootatpos();
  var_7 = randomfloatrange(-20, -8);
  var_6 = var_6 + (0, 0, var_7);
  var_8 = randomfloatrange(var_0, var_1);
  var_3 = var_3 * var_8;
  var_9 = var_3 * var_5;
  var_6 = var_6 + var_9;
  return var_6;
}

sawbladeattack_aim_begin(var_0, var_1) {
  self.aim_done_time = gettime() + 250;
}

sawbladeattack_aim_tick(var_0) {
  var_1 = scripts\mp\agents\slasher\slasher_agent::getenemy();

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  var_2 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.lookposition = calcenemytargetpos(var_2.sawblade_min_randomness, var_2.sawblade_max_randomness);

  if(gettime() >= self.aim_done_time) {
    if(self cansee(var_1)) {
      scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(var_0, "shoot");
    } else {
      self.aim_done_time = gettime() + 100;
    }
  }

  return 1;
}

sawbladeattack_aim_end(var_0, var_1) {
  self.aim_done_time = undefined;
}

sawbladeattack_shoot_begin(var_0, var_1) {
  scripts\asm\asm_bb::bb_requestfire(1);
}

sawbladeattack_shoot_tick(var_0) {
  var_1 = scripts\mp\agents\slasher\slasher_agent::getenemy();

  if(!isDefined(var_1) || !self cansee(var_1)) {
    scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(var_0, "aim");
    return 0;
  }

  var_2 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.lookposition = calcenemytargetpos(var_2.sawblade_min_randomness, var_2.sawblade_max_randomness);
  return 1;
}

sawbladeattack_shoot_end(var_0, var_1) {
  scripts\asm\asm_bb::bb_requestfire(0);
}

grenadethrow_begin(var_0) {
  var_1 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  scripts\asm\asm_bb::bb_requestthrowgrenade(1, var_1);
  scripts\asm\slasher\slasher_asm::setslasheraction("grenade_throw");
  self clearpath();
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(var_0, "grenade_throw", "grenade_throw");
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(var_0, "grenade_throw");
}

grenadethrow_tick(var_0) {
  if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(var_0)) {
    return anim.running;
  }

  return anim.failure;
}

grenadethrow_end(var_0) {
  scripts\asm\slasher\slasher_asm::clearslasheraction();
  var_1 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.next_grenade_throw_time = gettime() + randomintrange(var_1.min_grenade_throw_interval, var_1.max_grenade_throw_interval);
  self.enemygrenadepos = undefined;
  scripts\asm\asm_bb::bb_requestthrowgrenade(0);
  scripts\aitypes\slasher\bt_state_api::btstate_endstates(var_0);
}

melee_begin(var_0) {
  var_1 = getcurrentdesiredaction(var_0);
  scripts\asm\slasher\slasher_asm::setslasheraction(var_1);
  var_2 = scripts\mp\agents\slasher\slasher_agent::getenemy();

  if(var_1 == "swipe_attack") {
    var_3 = var_2 getvelocity();
    var_4 = length2dsquared(var_3);

    if(var_4 < 144) {
      self clearpath();
    } else {
      self.bmovingmelee = 1;
    }
  } else
    self clearpath();

  self.curmeleetarget = var_2;
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(var_0, var_1, var_1);
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(var_0, var_1);
}

melee_tick(var_0) {
  self clearpath();

  if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(var_0)) {
    return anim.running;
  }

  return anim.failure;
}

melee_end(var_0) {
  self.curmeleetarget = undefined;
  self.bmovingmelee = undefined;
  scripts\asm\slasher\slasher_asm::clearslasheraction();
  scripts\aitypes\slasher\bt_state_api::btstate_endstates(var_0);
}

block_begin(var_0) {
  self clearpath();
  scripts\asm\slasher\slasher_asm::setslasheraction("block");
  var_1 = scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(var_0);
  var_2 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  var_1.blockendtime = gettime() + randomintrange(var_2.min_block_time, var_2.max_block_time);
}

block_tick(var_0) {
  var_1 = scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(var_0);

  if(gettime() > var_1.blockendtime) {
    return anim.failure;
  }

  if(gettime() - self.damageaccumulator.lastdamagetime > scripts\mp\agents\slasher\slasher_tunedata::gettunedata().quit_block_if_no_damage_time) {
    return anim.failure;
  }

  return anim.running;
}

block_end(var_0) {
  scripts\asm\slasher\slasher_asm::clearslasheraction();
  var_1 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.nextblocktime = gettime() + randomintrange(var_1.min_block_interval, var_1.max_block_interval);
}

summon_begin(var_0) {
  self clearpath();
  scripts\asm\slasher\slasher_asm::setslasheraction("summon");
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(var_0, "summon", "summon");
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(var_0, "summon");
}

summon_tick(var_0) {
  if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(var_0)) {
    return anim.running;
  }

  return anim.failure;
}

summon_end(var_0) {
  scripts\asm\slasher\slasher_asm::clearslasheraction();
  self.lastsummontime = gettime();
  scripts\aitypes\slasher\bt_state_api::btstate_endstates(var_0);
}

teleport_begin(var_0) {
  self clearpath();
  var_1 = getcurrentdesiredaction(var_0);
  scripts\asm\slasher\slasher_asm::setslasheraction(var_1);
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(var_0, "teleport_in", "teleport_in", ::teleport_doteleport);
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(var_0, "teleport_in");
}

teleport_tick(var_0) {
  if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(var_0)) {
    return anim.running;
  }

  return anim.failure;
}

teleport_doteleport(var_0, var_1) {
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(var_0, "teleport_out", "teleport_out");
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(var_0, "teleport_out");
}

teleport_end(var_0) {
  self show();
  self.teleportpos = undefined;
  self.nextteleporttesttime = gettime() + scripts\mp\agents\slasher\slasher_tunedata::gettunedata().min_time_between_teleports;
  self.brecentlyteleported = 1;
  scripts\aitypes\slasher\bt_state_api::btstate_endstates(var_0);
  scripts\asm\slasher\slasher_asm::clearslasheraction();
}

taunt_begin(var_0) {
  self clearpath();
  self.brecentlyteleported = undefined;
  scripts\asm\slasher\slasher_asm::setslasheraction("taunt");
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(var_0, "taunt", "taunt", undefined, undefined, 3000);
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(var_0, "taunt");
}

taunt_tick(var_0) {
  if(tryblock()) {
    return anim.failure;
  }

  if(trymeleeattacks()) {
    return anim.failure;
  }

  if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(var_0)) {
    return anim.running;
  }

  return anim.failure;
}

taunt_end(var_0) {
  var_1 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.nexttaunttime = gettime() + randomintrange(var_1.min_taunt_interval, var_1.max_taunt_interval);
  scripts\aitypes\slasher\bt_state_api::btstate_endstates(var_0);
  scripts\asm\slasher\slasher_asm::clearslasheraction();
}

debughandler_begin(var_0) {}

debughandler_tick(var_0) {
  if(!isDefined(level.slasherdebugdestination)) {
    return anim.failure;
  }

  self scragentsetgoalradius(16);
  self scragentsetgoalpos(level.slasherdebugdestination);
  return anim.running;
}

debughandler_end(var_0) {}

ramattack_begin(var_0) {
  self clearpath();
  scripts\asm\slasher\slasher_asm::setslasheraction("ram_attack");
  self enablecollisionnotifies(1);
  var_1 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  self.curmeleetarget = var_1;
  var_2 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  scripts\aitypes\slasher\bt_state_api::chase_target_state_setup(var_0, var_2.ram_attack_chase_radius, self.curmeleetarget, ::ramattack_chasedone, var_2.ram_attack_timeout);
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(var_0, "chase");
}

ramattack_tick(var_0) {
  var_1 = scripts\mp\agents\slasher\slasher_agent::getenemy();

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  if(!isDefined(self.curmeleetarget)) {
    return anim.failure;
  }

  if(var_1 != self.curmeleetarget) {
    return anim.failure;
  }

  var_2 = distancesquared(self.origin, var_1.origin);
  var_3 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();

  if(var_2 > var_3.ram_attack_abort_dist_sq) {
    return anim.failure;
  }

  if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(var_0)) {
    var_4 = scripts\aitypes\slasher\bt_state_api::btstate_getcurrentstatename(var_0);

    if(isDefined(var_4) && var_4 == "chase") {
      var_5 = var_1 getvelocity();
      var_6 = self getvelocity();

      if(vectordot(var_5, var_6) < 0) {
        if(var_2 < var_3.ram_attack_chase_radius_if_playing_chicken * var_3.ram_attack_chase_radius_if_playing_chicken) {
          ramattack_chasedone(var_0, "success");
        }
      }
    }

    return anim.running;
  }

  return anim.failure;
}

ramattack_end(var_0) {
  scripts\aitypes\slasher\bt_state_api::btstate_endstates(var_0);
  scripts\asm\slasher\slasher_asm::clearslasheraction();
  var_1 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.nextramattacktesttime = gettime() + randomintrange(var_1.min_ram_attack_interval, var_1.max_ram_attack_interval);
  self.curmeleetarget = undefined;
  self.bramattackdamageoccured = undefined;
  self enablecollisionnotifies(0);
  scripts\asm\asm_bb::bb_clearmeleerequest();
}

ramattack_chasedone(var_0, var_1) {
  if(!isDefined(self.curmeleetarget) || !isalive(self.curmeleetarget)) {
    scripts\aitypes\slasher\bt_state_api::btstate_endstates(var_0);
    return;
  }

  if(var_1 == "timeout") {
    scripts\aitypes\slasher\bt_state_api::btstate_endstates(var_0);
    return;
  }

  scripts\asm\asm_bb::bb_requestmelee(self.curmeleetarget);
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(var_0, "ram", "ram_attack_anim", ::ramattack_done, "end");
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(var_0, "ram");
}

ramattack_done(var_0, var_1) {
  scripts\asm\asm_bb::bb_clearmeleerequestcomplete();
}

groundpoundattack_begin(var_0) {
  var_1 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  scripts\asm\slasher\slasher_asm::setslasheraction("ground_pound");
  self clearpath();
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(var_0, "slam", "ground_pound");
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(var_0, "slam");
}

groundpoundattack_tick(var_0) {
  if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(var_0)) {
    return anim.running;
  }

  return anim.failure;
}

groundpoundattack_end(var_0) {
  scripts\asm\slasher\slasher_asm::clearslasheraction();
}

sawbladeattack_begin(var_0) {
  scripts\asm\slasher\slasher_asm::setslasheraction("sawblade_attack");
  var_1 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(var_0).attackendtime = gettime() + randomintrange(var_1.min_sawblade_attack_time, var_1.max_sawblade_attack_time);
  self clearpath();
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(var_0, "aim");
}

sawbladeattack_tick(var_0) {
  self clearpath();
  var_1 = scripts\mp\agents\slasher\slasher_agent::getenemy();

  if(isDefined(var_1)) {
    var_2 = distancesquared(self.origin, var_1.origin);

    if(trymeleeattacks(var_2)) {
      return anim.failure;
    }

    if(tryblock()) {
      return anim.failure;
    }
  } else
    return anim.failure;

  scripts\aitypes\slasher\bt_state_api::btstate_tickstates(var_0);

  if(gettime() >= scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(var_0).attackendtime) {
    return anim.failure;
  }

  return anim.running;
}

sawbladeattack_end(var_0) {
  self.lookposition = undefined;
  scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(var_0).attackendtime = undefined;
  var_1 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.nextsawbladeattacktime = gettime() + randomintrange(var_1.min_sawblade_attack_interval, var_1.max_sawblade_attack_interval);
  scripts\aitypes\slasher\bt_state_api::btstate_endstates(var_0);
  scripts\asm\slasher\slasher_asm::clearslasheraction();
}

trysawbladeattack(var_0) {
  var_1 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  var_2 = gettime();

  if(!isDefined(self.nextsawbladeattacktime)) {
    self.nextsawbladeattacktime = var_2 + randomintrange(var_1.min_sawblade_attack_interval, var_1.max_sawblade_attack_interval);
  }

  if(var_2 < self.nextsawbladeattacktime) {
    return 0;
  }

  if(var_0 < var_1.min_sawblade_attack_dist_sq) {
    return 0;
  }

  if(var_0 > var_1.max_sawblade_attack_dist_sq) {
    return 0;
  }

  var_3 = scripts\mp\agents\slasher\slasher_agent::getenemy();

  if(!isDefined(self.enemyreacquiredtime) || var_2 - self.enemyreacquiredtime < var_1.min_clear_los_time_before_firing_saw) {
    return 0;
  }

  var_4 = anglesToForward(self.angles);
  var_5 = var_3.origin - self.origin;
  var_4 = (var_4[0], var_4[1], 0);
  var_5 = (var_5[0], var_5[1], 0);
  var_5 = vectornormalize(var_5);
  var_6 = vectordot(var_4, var_5);

  if(var_6 < -0.259) {
    return 0;
  }

  var_7 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  var_8 = [];
  var_9 = var_3 getEye();
  var_10 = self getEye() - (0, 0, 12);
  var_11 = physics_spherecast(var_10, var_9, 10, var_7, var_8, "physicsquery_closest");

  if(isDefined(var_11) && var_11.size > 0) {
    if(var_11[0]["fraction"] < 0.8) {
      self.nextsawbladeattacktime = var_2 + 500;
      return 0;
    }
  }

  self.desiredaction = "sawblade_attack";
  return 1;
}

tryramattack(var_0) {
  if(isDefined(self.nextramattacktesttime) && gettime() < self.nextramattacktesttime) {
    return 0;
  }

  var_1 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();

  if(var_0 < var_1.ram_attack_mindist_sq) {
    return 0;
  }

  if(var_0 > var_1.ram_attack_maxdist_sq) {
    return 0;
  }

  self.nextramattacktesttime = gettime() + 5000;
  var_2 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  var_3 = anglesToForward(self.angles);
  var_4 = var_2.origin;
  var_5 = var_4 - self.origin;
  var_3 = (var_3[0], var_3[1], 0);
  var_5 = vectornormalize((var_5[0], var_5[1], 0));
  var_6 = vectordot(var_3, var_5);

  if(var_6 < 0.707) {
    return 0;
  }

  if(!func_2AC(self.origin, var_4, self)) {
    self.nextramattacktesttime = gettime() + 500;
    return 0;
  }

  self.desiredaction = "ram_attack";
  return 1;
}

trytaunt(var_0) {
  var_1 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();

  if(!isDefined(self.nexttaunttime)) {
    self.nexttaunttime = gettime() + randomintrange(var_1.min_taunt_interval, var_1.max_taunt_interval);
  }

  if(!scripts\engine\utility::is_true(self.brecentlyteleported)) {
    if(var_0 < var_1.min_dist_to_enemy_for_taunt_sq) {
      return 0;
    }
  }

  if(gettime() > self.nexttaunttime) {
    if(randomint(100) < var_1.taunt_chance) {
      self.desiredaction = "taunt";
      return 1;
    } else
      self.nexttaunttime = gettime() + randomintrange(var_1.min_taunt_interval, var_1.max_taunt_interval);
  }

  return 0;
}

trysummon(var_0) {
  var_1 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();

  if(!isDefined(self.nextsummontime)) {
    self.nextsummontime = gettime() + randomintrange(var_1.min_summon_interval, var_1.max_summon_interval);
  }

  if(gettime() < self.nextsummontime) {
    return 0;
  }

  if(randomint(100) < var_1.summon_chance) {
    self.desiredaction = "summon";
    return 1;
  } else
    self.nextsummontime = gettime() + randomintrange(var_1.min_summon_interval, var_1.max_summon_interval);

  return 0;
}

tryblock() {
  if(!isDefined(self.damageaccumulator)) {
    return 0;
  }

  if(isDefined(self.nextblocktime) && gettime() < self.nextblocktime) {
    return 0;
  }

  var_0 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();

  if(gettime() - self.damageaccumulator.lastdamagetime > var_0.max_time_after_last_damage_to_block) {
    self.damageaccumulator.accumulateddamage = 0;
    return 0;
  }

  var_0 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();

  if(self.damageaccumulator.accumulateddamage > var_0.need_to_block_damage_threshold) {
    if(randomint(100) < var_0.block_chance) {
      self.desiredaction = "block";
      self.damageaccumulator.accumulateddamage = 0;
      return 1;
    } else
      self.damageaccumulator.accumulateddamage = self.damageaccumulator.accumulateddamage - var_0.need_to_block_damage_threshold / 2;
  }

  return 0;
}

findteleportdest() {
  var_0 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  var_1 = anglesToForward(var_0.angles);
  var_2 = getrandomnavpoints(var_0.origin, 1600, 16, self);

  foreach(var_4 in var_2) {
    var_5 = var_4 - var_0.origin;
    var_6 = length2dsquared(var_5);

    if(var_6 < 57600) {
      continue;
    }
    var_7 = vectornormalize(var_5);
    var_8 = vectordot(var_1, var_7);

    if(var_8 < 0.707) {
      continue;
    }
    return var_4;
  }

  return undefined;
}

tryemergencyteleport(var_0) {
  if(isDefined(self.nextteleporttesttime) && gettime() < self.nextteleporttesttime) {
    return 0;
  }

  var_1 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  var_2 = gettime();

  if(self.health >= self.last_health) {
    return 0;
  }

  self.last_health = self.health;
  var_3 = 0;
  var_4 = undefined;

  if(isDefined(self.pathgoalpos)) {
    var_4 = self pathdisttogoal();

    if(var_4 < var_1.min_path_dist_for_teleport) {
      self.nextteleporttesttime = var_2 + 250;
      self notify("Abort_FindJumpScareTeleportPos");
      self.findteleportposstatus = undefined;
      return 0;
    }
  }

  if(!isDefined(self.lastenemyengagetime)) {
    self.lastenemyengagetime = var_2;
  }

  if(!isDefined(self.findteleportposstatus)) {
    thread findjumpscareteleportpos(scripts\mp\agents\slasher\slasher_agent::getenemy(), var_1.min_jump_scare_dist_to_player, var_1.max_jump_scare_dist_to_player);
    return 0;
  }

  if(self.findteleportposstatus == "working") {
    return 0;
  }

  if(self.findteleportposstatus == "invalid") {
    self.findteleportposstatus = undefined;
    var_5 = findteleportdest();

    if(isDefined(var_5)) {
      self.teleportpos = var_5;
      self.desiredaction = "teleport";
      return 1;
    }
  } else if(self.findteleportposstatus == "success") {
    self.findteleportposstatus = undefined;
    self.desiredaction = "teleport";
    return 1;
  } else if(self.findteleportposstatus == "failure") {
    self.nextteleporttesttime = gettime() + 500;
    self.findteleportposstatus = undefined;
  }

  return 0;
}

tryteleport(var_0) {
  if(isDefined(self.nextteleporttesttime) && gettime() < self.nextteleporttesttime) {
    return 0;
  }

  var_1 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  var_2 = gettime();
  var_3 = 0;
  var_4 = undefined;

  if(isDefined(self.pathgoalpos)) {
    var_4 = self pathdisttogoal();

    if(var_4 < var_1.min_path_dist_for_teleport) {
      self.nextteleporttesttime = var_2 + 250;
      self notify("Abort_FindJumpScareTeleportPos");
      self.findteleportposstatus = undefined;
      return 0;
    }
  }

  if(!isDefined(self.lastenemyengagetime)) {
    self.lastenemyengagetime = var_2;
  }

  if(var_2 - self.lastenemysighttime > var_1.no_los_wait_time_before_teleport) {
    var_3 = 1;
  } else if(var_2 - self.lastenemyengagetime > var_1.attempt_teleport_if_no_engagement_within_time) {
    if(!isDefined(var_0)) {
      var_5 = scripts\mp\agents\slasher\slasher_agent::getenemy();
      var_0 = distancesquared(self.origin, var_5.origin);
    }

    if(var_0 > var_1.teleport_min_dist_to_enemy_to_teleport_sq) {
      var_3 = 1;
    } else if(isDefined(var_4)) {
      if(var_4 * var_4 > var_1.teleport_min_dist_to_enemy_to_teleport_sq) {
        var_3 = 1;
      }
    }
  }

  if(!var_3) {
    self.nextteleporttesttime = var_2 + 250;
    self notify("Abort_FindJumpScareTeleportPos");
    self.findteleportposstatus = undefined;
    return 0;
  }

  if(!isDefined(self.findteleportposstatus)) {
    thread findjumpscareteleportpos(scripts\mp\agents\slasher\slasher_agent::getenemy(), var_1.min_jump_scare_dist_to_player, var_1.max_jump_scare_dist_to_player);
    return 0;
  }

  if(self.findteleportposstatus == "working") {
    return 0;
  }

  if(self.findteleportposstatus == "invalid") {
    self.findteleportposstatus = undefined;
    var_6 = findteleportdest();

    if(isDefined(var_6)) {
      self.teleportpos = var_6;
      self.desiredaction = "teleport";
      return 1;
    }
  } else if(self.findteleportposstatus == "success") {
    self.findteleportposstatus = undefined;
    self.desiredaction = "teleport";
    return 1;
  } else if(self.findteleportposstatus == "failure") {
    self.nextteleporttesttime = gettime() + 500;
    self.findteleportposstatus = undefined;
  }

  return 0;
}

trymeleeattacks(var_0) {
  var_1 = scripts\mp\agents\slasher\slasher_agent::getenemy();

  if(!isDefined(var_0)) {
    var_0 = distancesquared(self.origin, var_1.origin);
  }

  var_2 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();

  if(var_0 > var_2.ground_pound_radius_sq) {
    return 0;
  }

  var_3 = 0;

  if(!ispointonnavmesh(var_1.origin)) {
    if(var_0 > self.meleeradiuswhentargetnotonnavmesh * self.meleeradiuswhentargetnotonnavmesh) {
      var_3 = 1;
    }
  } else if(var_0 > self.meleeradiusbasesq)
    var_3 = 1;

  if(var_3) {
    return 0;
  }

  var_4 = var_1.origin - self.origin;
  var_4 = (var_4[0], var_4[1], 0);
  var_5 = anglesToForward(self.angles);
  var_6 = vectornormalize(var_4);
  var_7 = vectordot(var_5, var_6);

  if(var_7 < self.meleedot) {
    self.desiredaction = "melee_spin";
    return 1;
  }

  if(randomint(100) < self.meleeattackchance["melee_spin"]) {
    self.desiredaction = "melee_spin";
    return 1;
  }

  self.desiredaction = "swipe_attack";
  return 1;
}

trygrenadethrow(var_0, var_1) {
  var_2 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  var_3 = scripts\mp\agents\slasher\slasher_agent::getenemy();

  if(!isDefined(var_1)) {
    var_1 = var_3.origin;
  }

  if(!isDefined(self.next_grenade_throw_time)) {
    self.next_grenade_throw_time = gettime() + randomintrange(var_2.min_grenade_throw_interval, var_2.max_grenade_throw_interval);
  }

  if(isDefined(self.next_grenade_throw_time) && gettime() < self.next_grenade_throw_time) {
    return 0;
  }

  self.next_grenade_throw_time = gettime() + 1000;

  if(var_0 < var_2.min_grenade_throw_dist_sq) {
    return 0;
  }

  if(var_0 > var_2.max_grenade_throw_dist_sq) {
    return 0;
  }

  var_4 = scripts\engine\utility::getyawtospot(var_1);

  if(abs(var_4) > 60) {
    return 0;
  }

  if(!self isgrenadepossafe(var_3, var_1)) {
    return 0;
  }

  var_5 = var_1;
  var_6 = scripts\mp\agents\slasher\slasher_agent::getslashergrenadehandoffset();
  var_7 = self getplayerassets(var_6, var_5, 0, "min time", "min energy");

  if(!isDefined(var_7)) {
    self.next_grenade_throw_time = gettime() + 500;
    return 0;
  }

  self.desiredaction = "grenade_throw";
  self.enemygrenadepos = var_5;
  return 1;
}

shouldtryramattack() {
  if(!isDefined(level.slasher_level) || level.slasher_level > 3) {
    return 1;
  }

  return level.slasher_level >= 1;
}

shouldtrygrenadethrow() {
  if(!isDefined(level.slasher_level) || level.slasher_level > 3) {
    return 1;
  }

  return level.slasher_level >= 3;
}

shouldtrysawbladeattack() {
  if(!isDefined(level.slasher_level) || level.slasher_level > 3) {
    return 1;
  }

  return level.slasher_level >= 2;
}

decideslasheraction(var_0) {
  if(isDefined(level.slasherdebugdestination)) {
    self.desiredaction = "debug_handler";
    return anim.success;
  }

  var_1 = scripts\mp\agents\slasher\slasher_agent::getenemy();

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  var_2 = gettime();

  if(tryblock()) {
    self.lastenemyengagetime = var_2;
    return anim.success;
  }

  if(var_2 - self.lastenemysighttime < 500) {
    var_3 = distancesquared(var_1.origin, self.origin);

    if(scripts\engine\utility::is_true(self.brecentlyteleported)) {
      if(trytaunt(var_3)) {
        self.brecentlyteleported = 0;
        return anim.success;
      }
    }

    if(trymeleeattacks(var_3)) {
      self.lastenemyengagetime = var_2;
      return anim.success;
    }

    if(shouldtrygrenadethrow() && trygrenadethrow(var_3)) {
      self.lastenemyengagetime = var_2;
      return anim.success;
    }

    if(shouldtrysawbladeattack() && trysawbladeattack(var_3)) {
      self.lastenemyengagetime = var_2;
      return anim.success;
    }

    if(shouldtryramattack() && tryramattack(var_3)) {
      self.lastenemyengagetime = var_2;
      return anim.success;
    }

    if(!scripts\engine\utility::is_true(self.brecentlyteleported)) {
      if(trytaunt(var_3)) {
        return anim.success;
      }
    }

    if(tryteleport(var_3)) {
      self.lastenemyengagetime = var_2;
      return anim.success;
    }
  } else {
    if(shouldtrygrenadethrow() && gettime() - self.lastenemysighttime < 1200) {
      var_4 = distancesquared(self.origin, self.lastenemysightpos);

      if(trygrenadethrow(var_4, self.lastenemysightpos)) {
        self.lastenemyengagetime = var_2;
        return anim.success;
      }
    }

    if(tryteleport()) {
      self.lastenemyengagetime = var_2;
      return anim.success;
    }
  }

  return anim.failure;
}

doslasheraction_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].slasheraction = self.desiredaction;
  var_1 = self.actions[self.desiredaction].fnbegin;
  self.desiredaction = undefined;

  if(isDefined(var_1)) {
    [[var_1]](var_0);
  }
}

doslasheraction_tick(var_0) {
  var_1 = getcurrentdesiredaction(var_0);

  if(var_1 != "debug_handler") {
    var_2 = scripts\mp\agents\slasher\slasher_agent::getenemy();

    if(!isDefined(var_2)) {
      return anim.failure;
    }
  }

  var_3 = self.actions[var_1].fntick;

  if(isDefined(var_3)) {
    var_4 = [[var_3]](var_0);

    if(!isDefined(self.desiredaction)) {
      return var_4;
    }
  }

  if(isDefined(self.desiredaction)) {
    doslasheraction_end(var_0);
    doslasheraction_begin(var_0);
    return anim.running;
  }

  return anim.failure;
}

doslasheraction_end(var_0) {
  var_1 = getcurrentdesiredaction(var_0);
  var_2 = self.actions[var_1].fnend;

  if(isDefined(var_2)) {
    [[var_2]](var_0);
  }

  scripts\aitypes\slasher\bt_state_api::btstate_endstates(var_0);
  self.bt.instancedata[var_0] = undefined;
}

followenemy_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
}

followenemy_tick(var_0) {
  var_1 = scripts\mp\agents\slasher\slasher_agent::getenemy();

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  var_2 = getclosestpointonnavmesh(var_1.origin, self);
  self scragentsetgoalpos(var_2);
  return anim.success;
}

followenemy_end(var_0) {
  self.bt.instancedata[var_0] = undefined;
}

findenemy_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
}

findenemy_tick(var_0) {
  return anim.failure;
}

findenemy_end(var_0) {
  self.bt.instancedata[var_0] = undefined;
}

findjumpscareteleportpos(var_0, var_1, var_2) {
  self endon("death");
  self notify("Abort_FindJumpScareTeleportPos");
  self endon("Abort_FindJumpScareTeleportPos");

  if(!isDefined(level.slasherteleportpoints)) {
    level.slasherteleportpoints = [];

    foreach(var_4 in getnodearray("slasher_teleport", "targetname")) {
      level.slasherteleportpoints[level.slasherteleportpoints.size] = var_4.origin;
    }
  }

  if(level.slasherteleportpoints.size == 0) {
    self.findteleportposstatus = "invalid";
    return;
  }

  var_6 = var_0 getvelocity();
  self.findteleportposstatus = "working";

  if(length2d(var_6) < 1) {
    self.findteleportposstatus = "failure";
    return;
  }

  var_7 = vectornormalize(var_6);
  var_8 = getclosestpointonnavmesh(var_0.origin);
  var_9 = [];

  foreach(var_11 in level.slasherteleportpoints) {
    var_12 = distance2dsquared(var_11, var_8);

    if(var_12 > var_1 * var_1 && var_12 < var_2 * var_2) {
      if(!is_near_any_player(var_11)) {
        var_9[var_9.size] = var_11;
      }
    }
  }

  if(var_9.size == 0) {
    self.findteleportposstatus = "failure";
    return;
  }

  scripts\engine\utility::array_randomize(var_9);

  foreach(var_11 in var_9) {
    var_15 = getclosestpointonnavmesh(var_11);
    var_16 = self findpath(var_8, var_15);

    if(!isDefined(var_16) || var_16.size < 2) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_17 = vectornormalize(var_16[1] - var_8);
    var_18 = vectordot(var_17, var_7);

    if(var_18 < 0.707) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_19 = calcpathdist(var_16);
    var_20 = distance(var_16[0], var_16[var_16.size - 1]);

    if(var_19 > var_20 * 3) {
      scripts\engine\utility::waitframe();
      continue;
    }

    self.findteleportposstatus = "success";
    self.teleportpos = var_11;
    return;
  }

  self.findteleportposstatus = "failure";
}

calcpathdist(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    var_1 = var_1 + distance(var_0[var_2], var_0[var_2 + 1]);
  }

  return var_1;
}

is_near_any_player(var_0) {
  var_1 = 90000;

  foreach(var_3 in level.players) {
    if(distancesquared(var_0, var_3.origin) < var_1) {
      return 1;
    }
  }

  return 0;
}