/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\slasher\behaviors.gsc
*************************************************/

initslasher(param_00) {
  setupslasherstates();
  self.desiredaction = undefined;
  self.lastenemysighttime = 0;
  self.lastenemyengagetime = 0;
  self.slasherenemy = undefined;
  self.slasherenemystarttime = 0;
  self.last_health = self.health;
  return level.success;
}

setupslasheraction(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.fnbegin = param_01;
  var_04.fntick = param_02;
  var_04.fnend = param_03;
  if(!isDefined(self.actions)) {
    self.actions = [];
  }

  self.actions[param_00] = var_04;
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

pickbetterenemy(param_00, param_01) {
  if(isDefined(self.slasherenemy)) {
    if(param_00 == self.slasherenemy) {
      if(gettime() - self.slasherenemystarttime < 3000) {
        return param_00;
      }
    } else if(param_01 == self.slasherenemy) {
      if(gettime() - self.slasherenemystarttime < 3000) {
        return param_01;
      }
    }
  }

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
  var_00 = undefined;
  var_01 = self isethereal();
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

    if(var_01 && !var_03 _meth_85BA()) {
      continue;
    }

    if(!isDefined(var_00)) {
      var_00 = var_03;
      continue;
    }

    var_00 = pickbetterenemy(var_00, var_03);
  }

  if(!isDefined(var_00)) {
    self.slasherenemy = undefined;
    return undefined;
  }

  if(!isDefined(self.slasherenemy) || var_00 != self.slasherenemy) {
    self.slasherenemy = var_00;
    self.slasherenemystarttime = gettime();
  }

  return self.slasherenemy;
}

updateslashereveryframe(param_00) {
  var_01 = updateenemy();
  if(isDefined(var_01)) {
    if(self getpersstat(var_01)) {
      self.lastenemysighttime = gettime();
      self.setignoremegroup = var_01.origin;
      if(!isDefined(self.enemyreacquiredtime)) {
        self.enemyreacquiredtime = self.lastenemysighttime;
      }
    } else {
      self.enemyreacquiredtime = undefined;
    }
  } else {
    self.lastenemysighttime = 0;
    self.setignoremegroup = undefined;
    self.enemyreacquiredtime = undefined;
  }

  return level.failure;
}

getcurrentdesiredaction(param_00) {
  return self.var_3135.instancedata[param_00].slasheraction;
}

calcenemytargetpos(param_00, param_01) {
  var_02 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  var_03 = var_02 getvelocity();
  var_04 = distance(var_02.origin, self.origin);
  var_05 = var_04 / 1500;
  var_06 = var_02 getshootatpos();
  var_07 = randomfloatrange(-20, -8);
  var_06 = var_06 + (0, 0, var_07);
  var_08 = randomfloatrange(param_00, param_01);
  var_03 = var_03 * var_08;
  var_09 = var_03 * var_05;
  var_06 = var_06 + var_09;
  return var_06;
}

sawbladeattack_aim_begin(param_00, param_01) {
  self.aim_done_time = gettime() + 250;
}

sawbladeattack_aim_tick(param_00) {
  var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(!isDefined(var_01)) {
    return level.failure;
  }

  var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.setplayerignoreradiusdamage = calcenemytargetpos(var_02.sawblade_min_randomness, var_02.sawblade_max_randomness);
  if(gettime() >= self.aim_done_time) {
    if(self getpersstat(var_01)) {
      scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00, "shoot");
    } else {
      self.aim_done_time = gettime() + 100;
    }
  }

  return 1;
}

sawbladeattack_aim_end(param_00, param_01) {
  self.aim_done_time = undefined;
}

sawbladeattack_shoot_begin(param_00, param_01) {
  scripts\asm\asm_bb::bb_requestfire(1);
}

sawbladeattack_shoot_tick(param_00) {
  var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(!isDefined(var_01) || !self getpersstat(var_01)) {
    scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00, "aim");
    return 0;
  }

  var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.setplayerignoreradiusdamage = calcenemytargetpos(var_02.sawblade_min_randomness, var_02.sawblade_max_randomness);
  return 1;
}

sawbladeattack_shoot_end(param_00, param_01) {
  scripts\asm\asm_bb::bb_requestfire(0);
}

grenadethrow_begin(param_00) {
  var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  scripts\asm\asm_bb::bb_requestthrowgrenade(1, var_01);
  scripts\asm\slasher\slasher_asm::setslasheraction("grenade_throw");
  self clearpath();
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00, "grenade_throw", "grenade_throw");
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00, "grenade_throw");
}

grenadethrow_tick(param_00) {
  if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.failure;
}

grenadethrow_end(param_00) {
  scripts\asm\slasher\slasher_asm::clearslasheraction();
  var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.next_grenade_throw_time = gettime() + randomintrange(var_01.min_grenade_throw_interval, var_01.max_grenade_throw_interval);
  self.enemygrenadepos = undefined;
  scripts\asm\asm_bb::bb_requestthrowgrenade(0);
  scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
}

melee_begin(param_00) {
  var_01 = getcurrentdesiredaction(param_00);
  scripts\asm\slasher\slasher_asm::setslasheraction(var_01);
  var_02 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(var_01 == "swipe_attack") {
    var_03 = var_02 getvelocity();
    var_04 = length2dsquared(var_03);
    if(var_04 < 144) {
      self clearpath();
    } else {
      self.bmovingmelee = 1;
    }
  } else {
    self clearpath();
  }

  self.curmeleetarget = var_02;
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00, var_01, var_01);
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00, var_01);
}

melee_tick(param_00) {
  self clearpath();
  if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.failure;
}

melee_end(param_00) {
  self.curmeleetarget = undefined;
  self.bmovingmelee = undefined;
  scripts\asm\slasher\slasher_asm::clearslasheraction();
  scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
}

block_begin(param_00) {
  self clearpath();
  scripts\asm\slasher\slasher_asm::setslasheraction("block");
  var_01 = scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(param_00);
  var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  var_01.blockendtime = gettime() + randomintrange(var_02.min_block_time, var_02.max_block_time);
}

block_tick(param_00) {
  var_01 = scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(param_00);
  if(gettime() > var_01.blockendtime) {
    return level.failure;
  }

  if(gettime() - self.damageaccumulator.lastdamagetime > scripts\mp\agents\slasher\slasher_tunedata::gettunedata().quit_block_if_no_damage_time) {
    return level.failure;
  }

  return level.running;
}

block_end(param_00) {
  scripts\asm\slasher\slasher_asm::clearslasheraction();
  var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.nextblocktime = gettime() + randomintrange(var_01.min_block_interval, var_01.max_block_interval);
}

summon_begin(param_00) {
  self clearpath();
  scripts\asm\slasher\slasher_asm::setslasheraction("summon");
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00, "summon", "summon");
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00, "summon");
}

summon_tick(param_00) {
  if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.failure;
}

summon_end(param_00) {
  scripts\asm\slasher\slasher_asm::clearslasheraction();
  self.lastsummontime = gettime();
  scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
}

teleport_begin(param_00) {
  self clearpath();
  var_01 = getcurrentdesiredaction(param_00);
  scripts\asm\slasher\slasher_asm::setslasheraction(var_01);
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00, "teleport_in", "teleport_in", ::teleport_doteleport);
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00, "teleport_in");
}

teleport_tick(param_00) {
  if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.failure;
}

teleport_doteleport(param_00, param_01) {
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00, "teleport_out", "teleport_out");
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00, "teleport_out");
}

teleport_end(param_00) {
  self show();
  self.teleportpos = undefined;
  self.nextteleporttesttime = gettime() + scripts\mp\agents\slasher\slasher_tunedata::gettunedata().min_time_between_teleports;
  self.brecentlyteleported = 1;
  scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
  scripts\asm\slasher\slasher_asm::clearslasheraction();
}

taunt_begin(param_00) {
  self clearpath();
  self.brecentlyteleported = undefined;
  scripts\asm\slasher\slasher_asm::setslasheraction("taunt");
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00, "taunt", "taunt", undefined, undefined, 3000);
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00, "taunt");
}

taunt_tick(param_00) {
  if(tryblock()) {
    return level.failure;
  }

  if(trymeleeattacks()) {
    return level.failure;
  }

  if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.failure;
}

taunt_end(param_00) {
  var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.nexttaunttime = gettime() + randomintrange(var_01.min_taunt_interval, var_01.max_taunt_interval);
  scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
  scripts\asm\slasher\slasher_asm::clearslasheraction();
}

debughandler_begin(param_00) {}

debughandler_tick(param_00) {
  if(!isDefined(level.slasherdebugdestination)) {
    return level.failure;
  }

  self ghostskulls_total_waves(16);
  self ghostskulls_complete_status(level.slasherdebugdestination);
  return level.running;
}

debughandler_end(param_00) {}

ramattack_begin(param_00) {
  self clearpath();
  scripts\asm\slasher\slasher_asm::setslasheraction("ram_attack");
  self enablecollisionnotifies(1);
  var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  self.curmeleetarget = var_01;
  var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  scripts\aitypes\slasher\bt_state_api::chase_target_state_setup(param_00, var_02.ram_attack_chase_radius, self.curmeleetarget, ::ramattack_chasedone, var_02.ram_attack_timeout);
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00, "chase");
}

ramattack_tick(param_00) {
  var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(!isDefined(var_01)) {
    return level.failure;
  }

  if(!isDefined(self.curmeleetarget)) {
    return level.failure;
  }

  if(var_01 != self.curmeleetarget) {
    return level.failure;
  }

  var_02 = distancesquared(self.origin, var_01.origin);
  var_03 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  if(var_02 > var_03.ram_attack_abort_dist_sq) {
    return level.failure;
  }

  if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00)) {
    var_04 = scripts\aitypes\slasher\bt_state_api::btstate_getcurrentstatename(param_00);
    if(isDefined(var_04) && var_04 == "chase") {
      var_05 = var_01 getvelocity();
      var_06 = self getvelocity();
      if(vectordot(var_05, var_06) < 0) {
        if(var_02 < var_03.ram_attack_chase_radius_if_playing_chicken * var_03.ram_attack_chase_radius_if_playing_chicken) {
          ramattack_chasedone(param_00, "success");
        }
      }
    }

    return level.running;
  }

  return level.failure;
}

ramattack_end(param_00) {
  scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
  scripts\asm\slasher\slasher_asm::clearslasheraction();
  var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.nextramattacktesttime = gettime() + randomintrange(var_01.min_ram_attack_interval, var_01.max_ram_attack_interval);
  self.curmeleetarget = undefined;
  self.bramattackdamageoccured = undefined;
  self enablecollisionnotifies(0);
  scripts\asm\asm_bb::bb_clearmeleerequest();
}

ramattack_chasedone(param_00, param_01) {
  if(!isDefined(self.curmeleetarget) || !isalive(self.curmeleetarget)) {
    scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
    return;
  }

  if(param_01 == "timeout") {
    scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
    return;
  }

  scripts\asm\asm_bb::bb_requestmelee(self.curmeleetarget);
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00, "ram", "ram_attack_anim", ::ramattack_done, "end");
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00, "ram");
}

ramattack_done(param_00, param_01) {
  scripts\asm\asm_bb::bb_clearmeleerequestcomplete();
}

groundpoundattack_begin(param_00) {
  var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  scripts\asm\slasher\slasher_asm::setslasheraction("ground_pound");
  self clearpath();
  scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00, "slam", "ground_pound");
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00, "slam");
}

groundpoundattack_tick(param_00) {
  if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.failure;
}

groundpoundattack_end(param_00) {
  scripts\asm\slasher\slasher_asm::clearslasheraction();
}

sawbladeattack_begin(param_00) {
  scripts\asm\slasher\slasher_asm::setslasheraction("sawblade_attack");
  var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(param_00).attackendtime = gettime() + randomintrange(var_01.min_sawblade_attack_time, var_01.max_sawblade_attack_time);
  self clearpath();
  scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00, "aim");
}

sawbladeattack_tick(param_00) {
  self clearpath();
  var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(isDefined(var_01)) {
    var_02 = distancesquared(self.origin, var_01.origin);
    if(trymeleeattacks(var_02)) {
      return level.failure;
    }

    if(tryblock()) {
      return level.failure;
    }
  } else {
    return level.failure;
  }

  scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00);
  if(gettime() >= scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(param_00).attackendtime) {
    return level.failure;
  }

  return level.running;
}

sawbladeattack_end(param_00) {
  self.setplayerignoreradiusdamage = undefined;
  scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(param_00).attackendtime = undefined;
  var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.nextsawbladeattacktime = gettime() + randomintrange(var_01.min_sawblade_attack_interval, var_01.max_sawblade_attack_interval);
  scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
  scripts\asm\slasher\slasher_asm::clearslasheraction();
}

trysawbladeattack(param_00) {
  var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  var_02 = gettime();
  if(!isDefined(self.nextsawbladeattacktime)) {
    self.nextsawbladeattacktime = var_02 + randomintrange(var_01.min_sawblade_attack_interval, var_01.max_sawblade_attack_interval);
  }

  if(var_02 < self.nextsawbladeattacktime) {
    return 0;
  }

  if(param_00 < var_01.min_sawblade_attack_dist_sq) {
    return 0;
  }

  if(param_00 > var_01.max_sawblade_attack_dist_sq) {
    return 0;
  }

  var_03 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(!isDefined(self.enemyreacquiredtime) || var_02 - self.enemyreacquiredtime < var_01.min_clear_los_time_before_firing_saw) {
    return 0;
  }

  var_04 = anglesToForward(self.angles);
  var_05 = var_03.origin - self.origin;
  var_04 = (var_04[0], var_04[1], 0);
  var_05 = (var_05[0], var_05[1], 0);
  var_05 = vectornormalize(var_05);
  var_06 = vectordot(var_04, var_05);
  if(var_06 < -0.259) {
    return 0;
  }

  var_07 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  var_08 = [];
  var_09 = var_03 getEye();
  var_0A = self getEye() - (0, 0, 12);
  var_0B = physics_spherecast(var_0A, var_09, 10, var_07, var_08, "physicsquery_closest");
  if(isDefined(var_0B) && var_0B.size > 0) {
    if(var_0B[0]["fraction"] < 0.8) {
      self.nextsawbladeattacktime = var_02 + 500;
      return 0;
    }
  }

  self.desiredaction = "sawblade_attack";
  return 1;
}

tryramattack(param_00) {
  if(isDefined(self.nextramattacktesttime) && gettime() < self.nextramattacktesttime) {
    return 0;
  }

  var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  if(param_00 < var_01.ram_attack_mindist_sq) {
    return 0;
  }

  if(param_00 > var_01.ram_attack_maxdist_sq) {
    return 0;
  }

  self.nextramattacktesttime = gettime() + 5000;
  var_02 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  var_03 = anglesToForward(self.angles);
  var_04 = var_02.origin;
  var_05 = var_04 - self.origin;
  var_03 = (var_03[0], var_03[1], 0);
  var_05 = vectornormalize((var_05[0], var_05[1], 0));
  var_06 = vectordot(var_03, var_05);
  if(var_06 < 0.707) {
    return 0;
  }

  if(!navisstraightlinereachable(self.origin, var_04, self)) {
    self.nextramattacktesttime = gettime() + 500;
    return 0;
  }

  self.desiredaction = "ram_attack";
  return 1;
}

trytaunt(param_00) {
  var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  if(!isDefined(self.nexttaunttime)) {
    self.nexttaunttime = gettime() + randomintrange(var_01.min_taunt_interval, var_01.max_taunt_interval);
  }

  if(!scripts\engine\utility::istrue(self.brecentlyteleported)) {
    if(param_00 < var_01.min_dist_to_enemy_for_taunt_sq) {
      return 0;
    }
  }

  if(gettime() > self.nexttaunttime) {
    if(randomint(100) < var_01.taunt_chance) {
      self.desiredaction = "taunt";
      return 1;
    } else {
      self.nexttaunttime = gettime() + randomintrange(var_01.min_taunt_interval, var_01.max_taunt_interval);
    }
  }

  return 0;
}

trysummon(param_00) {
  var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  if(!isDefined(self.nextsummontime)) {
    self.nextsummontime = gettime() + randomintrange(var_01.min_summon_interval, var_01.max_summon_interval);
  }

  if(gettime() < self.nextsummontime) {
    return 0;
  }

  if(randomint(100) < var_01.summon_chance) {
    self.desiredaction = "summon";
    return 1;
  } else {
    self.nextsummontime = gettime() + randomintrange(var_01.min_summon_interval, var_01.max_summon_interval);
  }

  return 0;
}

tryblock() {
  if(!isDefined(self.damageaccumulator)) {
    return 0;
  }

  if(isDefined(self.nextblocktime) && gettime() < self.nextblocktime) {
    return 0;
  }

  var_00 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  if(gettime() - self.damageaccumulator.lastdamagetime > var_00.max_time_after_last_damage_to_block) {
    self.damageaccumulator.accumulateddamage = 0;
    return 0;
  }

  var_00 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  if(self.damageaccumulator.accumulateddamage > var_00.need_to_block_damage_threshold) {
    if(randomint(100) < var_00.block_chance) {
      self.desiredaction = "block";
      self.damageaccumulator.accumulateddamage = 0;
      return 1;
    } else {
      self.damageaccumulator.accumulateddamage = self.damageaccumulator.accumulateddamage - var_00.need_to_block_damage_threshold / 2;
    }
  }

  return 0;
}

findteleportdest() {
  var_00 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  var_01 = anglesToForward(var_00.angles);
  var_02 = getrandomnavpoints(var_00.origin, 1600, 16, self);
  foreach(var_04 in var_02) {
    var_05 = var_04 - var_00.origin;
    var_06 = length2dsquared(var_05);
    if(var_06 < -7936) {
      continue;
    }

    var_07 = vectornormalize(var_05);
    var_08 = vectordot(var_01, var_07);
    if(var_08 < 0.707) {
      continue;
    }

    return var_04;
  }

  return undefined;
}

tryemergencyteleport(param_00) {
  if(isDefined(self.nextteleporttesttime) && gettime() < self.nextteleporttesttime) {
    return 0;
  }

  var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  var_02 = gettime();
  if(self.health >= self.last_health) {
    return 0;
  }

  self.last_health = self.health;
  var_03 = 0;
  var_04 = undefined;
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_04 = self pathdisttogoal();
    if(var_04 < var_01.min_path_dist_for_teleport) {
      self.nextteleporttesttime = var_02 + 250;
      self notify("Abort_FindJumpScareTeleportPos");
      self.findteleportposstatus = undefined;
      return 0;
    }
  }

  if(!isDefined(self.lastenemyengagetime)) {
    self.lastenemyengagetime = var_02;
  }

  if(!isDefined(self.findteleportposstatus)) {
    thread findjumpscareteleportpos(scripts\mp\agents\slasher\slasher_agent::getenemy(), var_01.min_jump_scare_dist_to_player, var_01.max_jump_scare_dist_to_player);
    return 0;
  }

  if(self.findteleportposstatus == "working") {
    return 0;
  }

  if(self.findteleportposstatus == "invalid") {
    self.findteleportposstatus = undefined;
    var_05 = findteleportdest();
    if(isDefined(var_05)) {
      self.teleportpos = var_05;
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

tryteleport(param_00) {
  if(isDefined(self.nextteleporttesttime) && gettime() < self.nextteleporttesttime) {
    return 0;
  }

  var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  var_02 = gettime();
  var_03 = 0;
  var_04 = undefined;
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_04 = self pathdisttogoal();
    if(var_04 < var_01.min_path_dist_for_teleport) {
      self.nextteleporttesttime = var_02 + 250;
      self notify("Abort_FindJumpScareTeleportPos");
      self.findteleportposstatus = undefined;
      return 0;
    }
  }

  if(!isDefined(self.lastenemyengagetime)) {
    self.lastenemyengagetime = var_02;
  }

  if(var_02 - self.lastenemysighttime > var_01.no_los_wait_time_before_teleport) {
    var_03 = 1;
  } else if(var_02 - self.lastenemyengagetime > var_01.attempt_teleport_if_no_engagement_within_time) {
    if(!isDefined(param_00)) {
      var_05 = scripts\mp\agents\slasher\slasher_agent::getenemy();
      param_00 = distancesquared(self.origin, var_05.origin);
    }

    if(param_00 > var_01.teleport_min_dist_to_enemy_to_teleport_sq) {
      var_03 = 1;
    } else if(isDefined(var_04)) {
      if(var_04 * var_04 > var_01.teleport_min_dist_to_enemy_to_teleport_sq) {
        var_03 = 1;
      }
    }
  }

  if(!var_03) {
    self.nextteleporttesttime = var_02 + 250;
    self notify("Abort_FindJumpScareTeleportPos");
    self.findteleportposstatus = undefined;
    return 0;
  }

  if(!isDefined(self.findteleportposstatus)) {
    thread findjumpscareteleportpos(scripts\mp\agents\slasher\slasher_agent::getenemy(), var_01.min_jump_scare_dist_to_player, var_01.max_jump_scare_dist_to_player);
    return 0;
  }

  if(self.findteleportposstatus == "working") {
    return 0;
  }

  if(self.findteleportposstatus == "invalid") {
    self.findteleportposstatus = undefined;
    var_06 = findteleportdest();
    if(isDefined(var_06)) {
      self.teleportpos = var_06;
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

trymeleeattacks(param_00) {
  var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(!isDefined(param_00)) {
    param_00 = distancesquared(self.origin, var_01.origin);
  }

  var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  if(param_00 > var_02.ground_pound_radius_sq) {
    return 0;
  }

  var_03 = 0;
  if(!ispointonnavmesh(var_01.origin)) {
    if(param_00 > self.meleeradiuswhentargetnotonnavmesh * self.meleeradiuswhentargetnotonnavmesh) {
      var_03 = 1;
    }
  } else if(param_00 > self.meleeradiusbasesq) {
    var_03 = 1;
  }

  if(var_03) {
    return 0;
  }

  var_04 = var_01.origin - self.origin;
  var_04 = (var_04[0], var_04[1], 0);
  var_05 = anglesToForward(self.angles);
  var_06 = vectornormalize(var_04);
  var_07 = vectordot(var_05, var_06);
  if(var_07 < self.meleedot) {
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

trygrenadethrow(param_00, param_01) {
  var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  var_03 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(!isDefined(param_01)) {
    param_01 = var_03.origin;
  }

  if(!isDefined(self.next_grenade_throw_time)) {
    self.next_grenade_throw_time = gettime() + randomintrange(var_02.min_grenade_throw_interval, var_02.max_grenade_throw_interval);
  }

  if(isDefined(self.next_grenade_throw_time) && gettime() < self.next_grenade_throw_time) {
    return 0;
  }

  self.next_grenade_throw_time = gettime() + 1000;
  if(param_00 < var_02.min_grenade_throw_dist_sq) {
    return 0;
  }

  if(param_00 > var_02.max_grenade_throw_dist_sq) {
    return 0;
  }

  var_04 = scripts\engine\utility::getyawtospot(param_01);
  if(abs(var_04) > 60) {
    return 0;
  }

  if(!self _meth_81A2(var_03, param_01)) {
    return 0;
  }

  var_05 = param_01;
  var_06 = scripts\mp\agents\slasher\slasher_agent::getslashergrenadehandoffset();
  var_07 = self getplayerassets(var_06, var_05, 0, "min time", "min energy");
  if(!isDefined(var_07)) {
    self.next_grenade_throw_time = gettime() + 500;
    return 0;
  }

  self.desiredaction = "grenade_throw";
  self.enemygrenadepos = var_05;
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

decideslasheraction(param_00) {
  if(isDefined(level.slasherdebugdestination)) {
    self.desiredaction = "debug_handler";
    return level.success;
  }

  var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(!isDefined(var_01)) {
    return level.failure;
  }

  var_02 = gettime();
  if(tryblock()) {
    self.lastenemyengagetime = var_02;
    return level.success;
  }

  if(var_02 - self.lastenemysighttime < 500) {
    var_03 = distancesquared(var_01.origin, self.origin);
    if(scripts\engine\utility::istrue(self.brecentlyteleported)) {
      if(trytaunt(var_03)) {
        self.brecentlyteleported = 0;
        return level.success;
      }
    }

    if(trymeleeattacks(var_03)) {
      self.lastenemyengagetime = var_02;
      return level.success;
    }

    if(shouldtrygrenadethrow() && trygrenadethrow(var_03)) {
      self.lastenemyengagetime = var_02;
      return level.success;
    }

    if(shouldtrysawbladeattack() && trysawbladeattack(var_03)) {
      self.lastenemyengagetime = var_02;
      return level.success;
    }

    if(shouldtryramattack() && tryramattack(var_03)) {
      self.lastenemyengagetime = var_02;
      return level.success;
    }

    if(!scripts\engine\utility::istrue(self.brecentlyteleported)) {
      if(trytaunt(var_03)) {
        return level.success;
      }
    }

    if(tryteleport(var_03)) {
      self.lastenemyengagetime = var_02;
      return level.success;
    }
  } else {
    if(shouldtrygrenadethrow() && gettime() - self.lastenemysighttime < 1200) {
      var_04 = distancesquared(self.origin, self.setignoremegroup);
      if(trygrenadethrow(var_04, self.setignoremegroup)) {
        self.lastenemyengagetime = var_02;
        return level.success;
      }
    }

    if(tryteleport()) {
      self.lastenemyengagetime = var_02;
      return level.success;
    }
  }

  return level.failure;
}

doslasheraction_begin(param_00) {
  self.var_3135.instancedata[param_00] = spawnStruct();
  self.var_3135.instancedata[param_00].slasheraction = self.desiredaction;
  var_01 = self.actions[self.desiredaction].fnbegin;
  self.desiredaction = undefined;
  if(isDefined(var_01)) {
    [[var_01]](param_00);
  }
}

doslasheraction_tick(param_00) {
  var_01 = getcurrentdesiredaction(param_00);
  if(var_01 != "debug_handler") {
    var_02 = scripts\mp\agents\slasher\slasher_agent::getenemy();
    if(!isDefined(var_02)) {
      return level.failure;
    }
  }

  var_03 = self.actions[var_01].fntick;
  if(isDefined(var_03)) {
    var_04 = [[var_03]](param_00);
    if(!isDefined(self.desiredaction)) {
      return var_04;
    }
  }

  if(isDefined(self.desiredaction)) {
    doslasheraction_end(param_00);
    doslasheraction_begin(param_00);
    return level.running;
  }

  return level.failure;
}

doslasheraction_end(param_00) {
  var_01 = getcurrentdesiredaction(param_00);
  var_02 = self.actions[var_01].fnend;
  if(isDefined(var_02)) {
    [[var_02]](param_00);
  }

  scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
  self.var_3135.instancedata[param_00] = undefined;
}

followenemy_begin(param_00) {
  self.var_3135.instancedata[param_00] = spawnStruct();
}

followenemy_tick(param_00) {
  var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
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

findjumpscareteleportpos(param_00, param_01, param_02) {
  self endon("death");
  self notify("Abort_FindJumpScareTeleportPos");
  self endon("Abort_FindJumpScareTeleportPos");
  if(!isDefined(level.slasherteleportpoints)) {
    level.slasherteleportpoints = [];
    foreach(var_04 in getnodearray("slasher_teleport", "targetname")) {
      level.slasherteleportpoints[level.slasherteleportpoints.size] = var_04.origin;
    }
  }

  if(level.slasherteleportpoints.size == 0) {
    self.findteleportposstatus = "invalid";
    return;
  }

  var_06 = param_00 getvelocity();
  self.findteleportposstatus = "working";
  if(length2d(var_06) < 1) {
    self.findteleportposstatus = "failure";
    return;
  }

  var_07 = vectornormalize(var_06);
  var_08 = getclosestpointonnavmesh(param_00.origin);
  var_09 = [];
  foreach(var_0B in level.slasherteleportpoints) {
    var_0C = distance2dsquared(var_0B, var_08);
    if(var_0C > param_01 * param_01 && var_0C < param_02 * param_02) {
      if(!is_near_any_player(var_0B)) {
        var_09[var_09.size] = var_0B;
      }
    }
  }

  if(var_09.size == 0) {
    self.findteleportposstatus = "failure";
    return;
  }

  scripts\engine\utility::array_randomize(var_09);
  foreach(var_0B in var_09) {
    var_0F = getclosestpointonnavmesh(var_0B);
    var_10 = self findpath(var_08, var_0F);
    if(!isDefined(var_10) || var_10.size < 2) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_11 = vectornormalize(var_10[1] - var_08);
    var_12 = vectordot(var_11, var_07);
    if(var_12 < 0.707) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_13 = calcpathdist(var_10);
    var_14 = distance(var_10[0], var_10[var_10.size - 1]);
    if(var_13 > var_14 * 3) {
      scripts\engine\utility::waitframe();
      continue;
    }

    self.findteleportposstatus = "success";
    self.teleportpos = var_0B;
    return;
  }

  self.findteleportposstatus = "failure";
}

calcpathdist(param_00) {
  var_01 = 0;
  for(var_02 = 0; var_02 < param_00.size - 1; var_02++) {
    var_01 = var_01 + distance(param_00[var_02], param_00[var_02 + 1]);
  }

  return var_01;
}

is_near_any_player(param_00) {
  var_01 = 90000;
  foreach(var_03 in level.players) {
    if(distancesquared(param_00, var_03.origin) < var_01) {
      return 1;
    }
  }

  return 0;
}