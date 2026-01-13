/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\aitypes\ratking\behaviors.gsc
*************************************************/

init(var_0) {
  setupbehaviorstates();
  self.desiredaction = undefined;
  self.lastenemysighttime = 0;
  self.lastenemyengagetime = 0;
  self.ratkingenemy = undefined;
  self.ratkingenemystarttime = 0;
  self.last_health = self.health;
  self.battackzombies = 0;
  scripts\asm\asm_bb::bb_requestmovetype("run");
  return level.success;
}

setupbtaction(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.fnbegin = var_1;
  var_4.fntick = var_2;
  var_4.fnend = var_3;
  if(!isDefined(self.actions)) {
    self.actions = [];
  }

  self.actions[var_0] = var_4;
}

setupbehaviorstates() {
  setupbtaction("melee_attack", ::melee_begin, ::melee_tick, ::melee_end);
  setupbtaction("staff_stomp", ::staffstompattack_begin, ::staffstompattack_tick, ::staffstompattack_end);
  setupbtaction("summon", ::summon_begin, ::summon_tick, ::summon_end);
  setupbtaction("block", ::block_begin, ::block_tick, ::block_end);
  setupbtaction("staff_projectile", ::staffprojectile_begin, ::staffprojectile_tick, ::staffprojectile_end);
  setupbtaction("shield_attack", ::shieldattack_begin, ::shieldattack_tick, ::shieldattack_end);
  setupbtaction("shield_attack_spot", ::shieldattackspot_begin, ::shieldattackspot_tick, ::shieldattackspot_end);
  setupbtaction("teleport", ::teleport_begin, ::teleport_tick, ::teleport_end);
  setupbtaction("debug_handler", ::debughandler_begin, ::debughandler_tick, ::debughandler_end);
}

pickbetterenemy(var_0, var_1) {
  if(isDefined(self.ratkingenemy)) {
    if(var_0 == self.ratkingenemy) {
      if(gettime() - self.ratkingenemystarttime < 3000) {
        return var_0;
      }
    } else if(var_1 == self.ratkingenemy) {
      if(gettime() - self.ratkingenemystarttime < 3000) {
        return var_1;
      }
    }
  }

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

updateenemy() {
  if(scripts\engine\utility::istrue(self.outofplayspace)) {
    self.ratkingenemy = undefined;
    return undefined;
  }

  if(scripts\engine\utility::istrue(self.battackzombies) && isDefined(self.zombietarget)) {
    if(isalive(self.zombietarget) && self.zombietarget.health >= 1) {
      if(isDefined(self.ratkingenemy) && self.zombietarget == self.ratkingenemy) {
        return self.ratkingenemy;
      }
    }
  }

  if(isDefined(self.ratkingenemy) && !shouldignoreenemy(self.ratkingenemy)) {
    if(gettime() - self.ratkingenemystarttime < 3000) {
      return self.ratkingenemy;
    }
  } else {
    self.ratkingenemy = undefined;
  }

  if(isDefined(self.ratkingenemy)) {
    var_0 = self.ratkingenemy;
  } else {
    var_0 = undefined;
  }

  foreach(var_2 in level.players) {
    if(shouldignoreenemy(var_2)) {
      continue;
    }

    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_2)) {
      continue;
    }

    if(isDefined(var_0) && isDefined(self.ratkingenemy) && self.ratkingenemy == var_2) {
      continue;
    } else {
      if(!isDefined(var_0)) {
        var_0 = var_2;
        continue;
      }

      var_0 = pickbetterenemy(var_0, var_2);
    }
  }

  if(!isDefined(var_0)) {
    self.ratkingenemy = undefined;
    return undefined;
  }

  if(!isDefined(self.ratkingenemy) || var_0 != self.ratkingenemy) {
    self.ratkingenemy = var_0;
    self.ratkingenemystarttime = gettime();
  }

  return self.ratkingenemy;
}

updateeveryframe(var_0) {
  var_1 = updateenemy();
  if(isDefined(var_1)) {
    if(self getpersstat(var_1)) {
      self.lastenemysighttime = gettime();
      self.setignoremegroup = var_1.origin;
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

getcurrentdesiredaction(var_0) {
  return self.bt.instancedata[var_0].ratkingaction;
}

melee_begin(var_0) {
  var_1 = getcurrentdesiredaction(var_0);
  scripts\asm\ratking\ratking_asm::setaction(var_1);
  var_2 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  var_3 = var_2 getvelocity();
  var_4 = length2dsquared(var_3);
  if(var_4 < 144) {
    self clearpath();
  } else {
    self.bmovingmelee = 1;
  }

  self.curmeleetarget = var_2;
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(var_0, var_1, var_1);
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(var_0, var_1);
}

melee_tick(var_0) {
  if(scripts\engine\utility::istrue(self.force_teleport)) {
    self.remove_shield = undefined;
    self.remove_staff = undefined;
    return level.failure;
  }

  self clearpath();
  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.failure;
}

melee_end(var_0) {
  self.curmeleetarget = undefined;
  self.bmovingmelee = undefined;
  scripts\asm\ratking\ratking_asm::clearaction();
  scripts\aitypes\ratking\bt_state_api::btstate_endstates(var_0);
}

block_begin(var_0) {
  self clearpath();
  scripts\asm\ratking\ratking_asm::setaction("block");
  var_1 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(var_0);
  var_2 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  var_1.blockendtime = gettime() + randomintrange(var_2.min_block_time, var_2.max_block_time);
  self.blocking = 1;
}

block_tick(var_0) {
  if(scripts\engine\utility::istrue(self.force_teleport)) {
    self.remove_shield = undefined;
    self.remove_staff = undefined;
    return level.failure;
  }

  var_1 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(var_0);
  var_2 = gettime();
  if(var_2 > var_1.blockendtime) {
    self.remove_shield = undefined;
    return level.failure;
  }

  if(scripts\engine\utility::istrue(self.remove_shield)) {
    self.remove_shield = undefined;
    return level.failure;
  }

  var_3 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  if(!scripts\mp\agents\ratking\ratking_agent::rkhasshield()) {
    self.remove_shield = undefined;
    return level.failure;
  }

  if(var_2 - self.damageaccumulator.lastdamagetime > var_3.quit_block_if_no_damage_time) {
    self.remove_shield = undefined;
    return level.failure;
  }

  return level.running;
}

block_end(var_0) {
  scripts\asm\ratking\ratking_asm::clearaction();
  var_1 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  self.nextblocktime = gettime() + randomintrange(var_1.min_block_interval, var_1.max_block_interval);
  self.blocking = undefined;
}

summon_begin(var_0) {
  self clearpath();
  scripts\asm\ratking\ratking_asm::setaction("summon");
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(var_0, "summon", "summon");
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(var_0, "summon");
}

summon_tick(var_0) {
  if(scripts\engine\utility::istrue(self.force_teleport)) {
    self.remove_shield = undefined;
    self.remove_staff = undefined;
    return level.failure;
  }

  if(scripts\engine\utility::istrue(self.remove_staff)) {
    self.remove_staff = undefined;
    return level.failure;
  }

  if(!scripts\mp\agents\ratking\ratking_agent::rkhasstaff()) {
    self.remove_staff = undefined;
    return level.failure;
  }

  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  self.remove_staff = undefined;
  return level.failure;
}

summon_end(var_0) {
  scripts\asm\ratking\ratking_asm::clearaction();
  var_1 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  self.nextsummontime = gettime() + randomintrange(var_1.min_summon_interval, var_1.max_summon_interval);
  scripts\aitypes\ratking\bt_state_api::btstate_endstates(var_0);
}

debughandler_begin(var_0) {}

debughandler_tick(var_0) {
  if(!isDefined(level.ratkingdebugdestination)) {
    return level.failure;
  }

  self ghostskulls_total_waves(16);
  self ghostskulls_complete_status(level.ratkingdebugdestination);
  return level.running;
}

debughandler_end(var_0) {}

shieldattackspot_begin(var_0) {
  var_1 = scripts\mp\agents\ratking\ratking_agent::getstructpos();
  scripts\asm\ratking\ratking_asm::setaction("shield_throw_at_spot");
  self clearpath();
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(var_0, "shieldattack", "shield_throw_at_spot");
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(var_0, "shieldattack");
}

shieldattack_begin(var_0) {
  var_1 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  scripts\asm\ratking\ratking_asm::setaction("shield_throw");
  self clearpath();
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(var_0, "shieldattack", "shield_throw");
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(var_0, "shieldattack");
}

shieldattackspot_tick(var_0) {
  if(scripts\engine\utility::istrue(self.force_teleport)) {
    self.remove_shield = undefined;
    self.remove_staff = undefined;
    return level.failure;
  }

  if(scripts\engine\utility::istrue(self.remove_shield)) {
    self.remove_shield = undefined;
    return level.failure;
  }

  if(!scripts\mp\agents\ratking\ratking_agent::rkhasshield()) {
    self.remove_shield = undefined;
    return level.failure;
  }

  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  self.remove_shield = undefined;
  return level.failure;
}

shieldattack_tick(var_0) {
  if(scripts\engine\utility::istrue(self.force_teleport)) {
    self.remove_shield = undefined;
    self.remove_staff = undefined;
    return level.failure;
  }

  if(scripts\engine\utility::istrue(self.remove_shield)) {
    self.remove_shield = undefined;
    return level.failure;
  }

  if(!scripts\mp\agents\ratking\ratking_agent::rkhasshield()) {
    self.remove_shield = undefined;
    return level.failure;
  }

  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  self.remove_shield = undefined;
  return level.failure;
}

shieldattackspot_end(var_0) {
  scripts\asm\ratking\ratking_asm::clearaction();
  var_1 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  self.ratkingbouncetarget = undefined;
  var_2 = randomintrange(var_1.staff_shield_attack_interval_min, var_1.staff_shield_attack_interval_max);
  self.nextshieldattacktime = gettime() + var_2;
}

shieldattack_end(var_0) {
  scripts\asm\ratking\ratking_asm::clearaction();
  var_1 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  var_2 = randomintrange(var_1.staff_shield_attack_interval_min, var_1.staff_shield_attack_interval_max);
  self.nextshieldattacktime = gettime() + var_2;
}

staffprojectile_begin(var_0) {
  var_1 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  scripts\asm\ratking\ratking_asm::setaction("staff_projectile");
  self clearpath();
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(var_0, "projectile", "staff_projectile");
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(var_0, "projectile");
  self.staffproj = 1;
}

staffprojectile_tick(var_0) {
  if(scripts\engine\utility::istrue(self.force_teleport)) {
    self.remove_shield = undefined;
    self.remove_staff = undefined;
    return level.failure;
  }

  if(scripts\engine\utility::istrue(self.remove_staff)) {
    self.remove_staff = undefined;
    return level.failure;
  }

  if(!scripts\mp\agents\ratking\ratking_agent::rkhasstaff()) {
    self.remove_staff = undefined;
    return level.failure;
  }

  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  self.remove_staff = undefined;
  return level.failure;
}

staffprojectile_end(var_0) {
  scripts\asm\ratking\ratking_asm::clearaction();
  var_1 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  var_2 = randomintrange(var_1.staff_projectile_interval_min, var_1.staff_projectile_interval_max);
  self.nextstaffprojectiletime = gettime() + var_2;
  self.staffproj = undefined;
}

staffstompattack_begin(var_0) {
  var_1 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  scripts\asm\ratking\ratking_asm::setaction("staff_stomp");
  self clearpath();
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(var_0, "stomp", "staff_stomp");
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(var_0, "stomp");
  self.stomp = 1;
}

staffstompattack_tick(var_0) {
  if(scripts\engine\utility::istrue(self.force_teleport)) {
    self.remove_shield = undefined;
    self.remove_staff = undefined;
    return level.failure;
  }

  if(scripts\engine\utility::istrue(self.remove_staff)) {
    self.remove_staff = undefined;
    return level.failure;
  }

  if(!scripts\mp\agents\ratking\ratking_agent::rkhasstaff()) {
    self.remove_staff = undefined;
    return level.failure;
  }

  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  self.remove_staff = undefined;
  return level.failure;
}

staffstompattack_end(var_0) {
  scripts\asm\ratking\ratking_asm::clearaction();
  self.nextstaffstomptime = gettime() + scripts\mp\agents\ratking\ratking_tunedata::gettunedata().staff_stomp_interval;
  self.nextstaffstompinnertime = gettime() + scripts\mp\agents\ratking\ratking_tunedata::gettunedata().staff_stomp_inner_interval;
  self.stomp = undefined;
}

teleport_begin(var_0) {
  self clearpath();
  var_1 = getcurrentdesiredaction(var_0);
  scripts\asm\ratking\ratking_asm::setaction(var_1);
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(var_0, "teleport_in", "teleport_in", ::teleport_doteleport);
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(var_0, "teleport_in");
}

teleport_tick(var_0) {
  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.failure;
}

teleport_doteleport(var_0, var_1) {
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(var_0, "teleport_out", "teleport_out");
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(var_0, "teleport_out");
}

teleport_end(var_0) {
  self show();
  var_1 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  self.nextteleporttesttime = gettime() + var_1.min_time_between_teleports;
  self.nexttraversalteleporttesttime = gettime() + var_1.min_time_between_traversal_teleports;
  self.brecentlyteleported = 1;
  self.teleporttospot = undefined;
  if(scripts\engine\utility::istrue(level.rat_king.force_teleport)) {
    thread scripts\cp\maps\cp_disco\rat_king_fight::restorerktuning();
    thread scripts\cp\maps\cp_disco\rat_king_fight::restorerkstagetoggles();
    level.rat_king.force_teleport = undefined;
  }

  scripts\aitypes\ratking\bt_state_api::btstate_endstates(var_0);
  scripts\asm\ratking\ratking_asm::clearaction();
}

isnearanypointinarray(var_0, var_1, var_2) {
  foreach(var_4 in var_1) {
    var_5 = distancesquared(var_4, var_0);
    if(var_5 < var_2) {
      return 1;
    }
  }

  return 0;
}

isnearagents(var_0, var_1, var_2) {
  foreach(var_4 in var_1) {
    var_5 = distancesquared(var_4.origin, var_0);
    if(var_5 < var_2) {
      return 1;
    }
  }

  return 0;
}

calcsummonspawnpoints(var_0, var_1) {
  var_2 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  var_3 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  if(scripts\engine\utility::flag("rk_fight_started")) {
    var_4 = getrandomnavpoints(level.rk_center_arena_struct.origin, var_2.summon_max_radius, 64, self);
  } else if(isDefined(var_4)) {
    var_4 = getrandomnavpoints(var_4.origin, var_3.summon_max_radius, 64, self);
  } else {
    var_4 = getrandomnavpoints(self.origin, var_3.summon_max_radius, 64, self);
  }

  scripts\engine\utility::array_randomize(var_4);
  var_5 = var_2.summon_min_radius * var_2.summon_min_radius;
  self.spawnpoints = [];
  foreach(var_7 in var_4) {
    var_8 = distancesquared(var_7, self.origin);
    if(var_8 < var_5) {
      continue;
    }

    if(isDefined(level.pam_grier)) {
      var_8 = distancesquared(var_7, level.pam_grier.origin);
      if(var_8 < var_5) {
        continue;
      }
    }

    if(is_near_any_player(var_7)) {
      continue;
    }

    if(isnearanypointinarray(var_7, self.spawnpoints, var_2.summon_spawn_min_dist_between_agents_sq)) {
      continue;
    }

    if(isnearagents(var_7, var_1, var_2.summon_spawn_min_dist_between_agents_sq)) {
      continue;
    }

    self.spawnpoints[self.spawnpoints.size] = var_7;
    if(self.spawnpoints.size >= var_0) {
      break;
    }
  }

  if(self.spawnpoints.size > 0) {
    return 1;
  }

  return 0;
}

trysummon(var_0) {
  var_1 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  if(!isDefined(self.nextsummontime)) {
    self.nextsummontime = gettime() + randomintrange(var_1.min_summon_interval, var_1.max_summon_interval);
  }

  if(gettime() < self.nextsummontime) {
    return 0;
  }

  var_2 = scripts\mp\mp_agent::getactiveagentsoftype(var_1.summon_agent_type);
  if(var_2.size > var_1.max_num_agents_to_allow_summon) {
    self.nextsummontime = gettime() + 1000;
    return 0;
  }

  if(isDefined(self.lastsummontime)) {
    self.lastsummontime = undefined;
    self.nextsummontime = gettime() + var_1.min_time_between_summon_rounds;
  }

  if(randomint(100) < var_1.summon_chance) {
    var_3 = randomintrange(var_1.summon_min_spawn_num, var_1.summon_max_spawn_num);
    if(calcsummonspawnpoints(var_3, var_2)) {
      self.desiredaction = "summon";
      self.lastsummontime = gettime();
      return 1;
    }
  }

  self.nextsummontime = gettime() + randomintrange(var_1.min_summon_interval, var_1.max_summon_interval);
  return 0;
}

tryblock() {
  if(!scripts\mp\agents\ratking\ratking_agent::rkhasshield()) {
    return 0;
  }

  if(!isDefined(self.damageaccumulator)) {
    return 0;
  }

  if(isDefined(self.nextblocktime) && gettime() < self.nextblocktime) {
    return 0;
  }

  var_0 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  if(gettime() - self.damageaccumulator.lastdamagetime > var_0.max_time_after_last_damage_to_block) {
    self.damageaccumulator.accumulateddamage = 0;
    return 0;
  }

  var_0 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  if(self.damageaccumulator.accumulateddamage > var_0.need_to_block_damage_threshold) {
    if(randomint(100) < var_0.block_chance) {
      self.desiredaction = "block";
      self.damageaccumulator.accumulateddamage = 0;
      return 1;
    } else {
      self.damageaccumulator.accumulateddamage = self.damageaccumulator.accumulateddamage - var_0.need_to_block_damage_threshold / 2;
    }
  }

  return 0;
}

tryshieldattackatpos(var_0) {
  if(!scripts\mp\agents\ratking\ratking_agent::rkhasshield()) {
    return 0;
  }

  var_1 = level.rat_king_bounce_structs;
  if(isDefined(level.inactive_eye_targets)) {
    var_1 = level.inactive_eye_targets;
  }

  var_2 = gettime();
  if(isDefined(self.nextshieldattacktime)) {
    if(var_2 < self.nextshieldattacktime) {
      return 0;
    }
  }

  var_3 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  if(var_0 < var_3.staff_shield_attack_min_dist_sq) {
    return 0;
  }

  if(var_0 > var_3.staff_shield_attack_max_dist_sq) {
    return 0;
  }

  if(!isDefined(self.enemyreacquiredtime) || var_2 - self.enemyreacquiredtime < var_3.min_clear_los_time_before_shield_attack) {
    return 0;
  }

  var_1 = scripts\engine\utility::array_randomize_objects(var_1);
  foreach(var_5 in var_1) {
    var_6 = anglesToForward(self.angles);
    var_7 = var_5.origin - self.origin;
    var_6 = (var_6[0], var_6[1], 0);
    var_7 = (var_7[0], var_7[1], 0);
    var_7 = vectornormalize(var_7);
    var_8 = vectordot(var_6, var_7);
    if(var_8 < -0.259) {
      continue;
    }

    var_9 = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 0, 0);
    var_0A = [];
    var_0B = var_5.origin;
    var_0C = self.origin + (0, 0, 30);
    var_0D = physics_spherecast(var_0C, var_0B, 10, var_9, var_0A, "physicsquery_closest");
    if(isDefined(var_0D) && var_0D.size > 0) {
      if(var_0D[0]["fraction"] < 0.95) {
        continue;
      }
    }

    self.desiredaction = "shield_attack_spot";
    self.ratkingbouncetarget = var_5;
    return 1;
  }

  self.nextshieldattacktime = var_2 + 500;
  return 0;
}

tryshieldattack(var_0) {
  if(!scripts\mp\agents\ratking\ratking_agent::rkhasshield()) {
    return 0;
  }

  var_1 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  var_2 = gettime();
  if(isDefined(self.nextshieldattacktime)) {
    if(var_2 < self.nextshieldattacktime) {
      return 0;
    }
  }

  var_3 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  if(var_0 < var_3.staff_shield_attack_min_dist_sq) {
    return 0;
  }

  if(var_0 > var_3.staff_shield_attack_max_dist_sq) {
    return 0;
  }

  if(!isDefined(self.enemyreacquiredtime) || var_2 - self.enemyreacquiredtime < var_3.min_clear_los_time_before_shield_attack) {
    return 0;
  }

  var_4 = anglesToForward(self.angles);
  var_5 = var_1.origin - self.origin;
  var_4 = (var_4[0], var_4[1], 0);
  var_5 = (var_5[0], var_5[1], 0);
  var_5 = vectornormalize(var_5);
  var_6 = vectordot(var_4, var_5);
  if(var_6 < -0.259) {
    self.nextshieldattacktime = var_2 + 500;
    return 0;
  }

  var_7 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  var_8 = [];
  var_9 = var_1 getEye() - (0, 0, 12);
  var_0A = self getEye() - (0, 0, 12);
  var_0B = physics_spherecast(var_0A, var_9, 10, var_7, var_8, "physicsquery_closest");
  if(isDefined(var_0B) && var_0B.size > 0) {
    if(var_0B[0]["fraction"] < 0.8) {
      self.nextshieldattacktime = var_2 + 500;
      return 0;
    }
  }

  self.desiredaction = "shield_attack";
  return 1;
}

trystaffprojectile(var_0) {
  var_1 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  if(isDefined(self.nextstaffprojectiletime)) {
    if(gettime() < self.nextstaffprojectiletime) {
      return 0;
    }
  }

  var_2 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  if(var_0 < var_2.staff_projectile_min_dist_sq) {
    return 0;
  }

  if(var_0 > var_2.staff_projectile_max_dist_sq) {
    return 0;
  }

  if(!navisstraightlinereachable(self.origin, var_1.origin, self)) {
    self.nextstaffprojectiletime = gettime() + 500;
    return 0;
  }

  self.desiredaction = "staff_projectile";
  return 1;
}

trystaffstomp(var_0) {
  if(rk_isonplatform()) {
    return 0;
  }

  var_1 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  if(!isDefined(var_0)) {
    var_0 = distancesquared(self.origin, var_1.origin);
  }

  var_2 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  if(var_0 > var_2.staff_stomp_outer_radius_sq) {
    return 0;
  }

  self.desiredaction = "staff_stomp";
  return 1;
}

trymeleeattacks(var_0) {
  if(rk_isonplatform()) {
    return 0;
  }

  var_1 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  if(!isDefined(var_0)) {
    var_0 = distancesquared(self.origin, var_1.origin);
  }

  var_2 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  var_3 = gettime();
  var_4 = shouldtrystomp();
  var_5 = 0;
  var_6 = 0;
  if(var_0 > var_2.staff_stomp_inner_radius_sq) {
    if(var_0 > var_2.staff_stomp_outer_radius_sq) {
      return 0;
    }

    if(isDefined(self.nextstaffstomptime) && var_3 < self.nextstaffstomptime) {
      return 0;
    }
  } else if(isDefined(self.nextstaffstompinnertime) && var_3 < self.nextstaffstompinnertime) {
    var_6 = 1;
  }

  if(!ispointonnavmesh(var_1.origin)) {
    if(var_0 > self.meleeradiuswhentargetnotonnavmesh * self.meleeradiuswhentargetnotonnavmesh) {
      var_6 = 1;
    }
  } else if(var_0 > self.meleeradiusbasesq) {
    var_6 = 1;
  }

  if(var_4 && var_6 && !var_5) {
    self.desiredaction = "staff_stomp";
    return 1;
  }

  var_7 = var_1.origin - self.origin;
  var_7 = (var_7[0], var_7[1], 0);
  var_8 = anglesToForward(self.angles);
  var_9 = vectornormalize(var_7);
  var_0A = vectordot(var_8, var_9);
  if(var_0A < self.meleedot) {
    if(var_4) {
      return 0;
    }

    if(var_5) {
      return 0;
    }

    self.desiredaction = "staff_stomp";
    return 1;
  }

  if(var_4 && !var_5) {
    if(randomint(100) < self.meleeattackchance["staff_stomp"]) {
      self.desiredaction = "staff_stomp";
      return 1;
    }
  } else if(var_6) {
    return 0;
  }

  self.desiredaction = "melee_attack";
  return 1;
}

distancecompare(var_0, var_1) {
  var_2 = distance2dsquared(level.rk_center_arena_struct.origin, var_0.origin);
  var_3 = distance2dsquared(level.rk_center_arena_struct.origin, var_1.origin);
  return var_2 < var_3;
}

tryattackzombies() {
  var_0 = gettime();
  if(isDefined(self.nextstaffstomptime) && var_0 < self.nextstaffstomptime) {
    return 0;
  }

  var_1 = scripts\cp\maps\cp_disco\rat_king_fight::getbrainattractorzombies();
  var_2 = scripts\engine\utility::array_sort_with_func(var_1, ::distancecompare);
  self.zombietarget = undefined;
  foreach(var_4 in var_2) {
    if(var_4 == self) {
      continue;
    }

    if(var_4 == self) {
      continue;
    }

    if(!isalive(var_4)) {
      continue;
    }

    if(var_4.health < 1) {
      continue;
    }

    if(distance(var_4.origin, level.rk_center_arena_struct.origin) >= 250) {
      continue;
    }

    if(isDefined(var_4.isnodeoccupied)) {
      if(isplayer(var_4.isnodeoccupied)) {
        continue;
      }
    }

    self.zombietarget = var_4;
    break;
  }

  if(!isDefined(self.zombietarget)) {
    return 0;
  }

  self.ratkingenemy = self.zombietarget;
  var_6 = distancesquared(self.origin, self.zombietarget.origin);
  if(trystaffstomp(var_6)) {
    return 1;
  }

  self.teleportpos = self.zombietarget.origin - anglesToForward(self.zombietarget.angles) * 48;
  self.findteleportposstatus = undefined;
  self.desiredaction = "teleport";
  return 1;
}

tryteleport(var_0) {
  if(!scripts\engine\utility::istrue(self.force_teleport)) {
    if(isDefined(self.nextteleporttesttime) && gettime() < self.nextteleporttesttime) {
      return 0;
    }
  }

  var_1 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  var_2 = gettime();
  var_3 = 0;
  var_4 = undefined;
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_4 = self pathdisttogoal();
    if(var_4 < var_1.min_path_dist_for_teleport) {
      self.nextteleporttesttime = var_2 + 250;
      self notify("Abort_FindTeleportPos");
      self.findteleportposstatus = undefined;
      return 0;
    }

    var_5 = self func_84F9(var_4);
    if(shouldtrytraversalteleport() && isDefined(var_5)) {
      var_6 = var_5["node"];
      var_7 = var_5["position"];
      var_8 = var_6.opcode::OP_ScriptMethodCallPointer;
      if(isDefined(var_8)) {
        var_9 = self.asmname;
        var_0A = level.asm[var_9];
        var_0B = var_0A.states[var_8];
        if(!isDefined(var_0B)) {
          var_8 = "traverse_external";
        }

        if(var_8 == "traverse_external") {
          self.teleportpos = var_7;
          self.desiredaction = "teleport";
          return level.success;
        }
      }
    }
  }

  if(!isDefined(self.lastenemyengagetime)) {
    self.lastenemyengagetime = var_2;
  }

  if(rk_shouldbeonplatform()) {
    var_3 = 1;
  } else if(var_2 - self.lastenemysighttime > var_1.no_los_wait_time_before_teleport) {
    var_3 = 1;
  } else if(var_2 - self.lastenemyengagetime > var_1.attempt_teleport_if_no_engagement_within_time) {
    if(!isDefined(var_0)) {
      var_0C = scripts\mp\agents\ratking\ratking_agent::getenemy();
      var_0 = distancesquared(self.origin, var_0C.origin);
    }

    if(var_0 > var_1.teleport_min_dist_to_enemy_to_teleport_sq) {
      var_3 = 1;
    } else if(isDefined(var_4)) {
      if(var_4 * var_4 > var_1.teleport_min_dist_to_enemy_to_teleport_sq) {
        var_3 = 1;
      }
    }
  }

  if(scripts\engine\utility::istrue(self.bshouldfastteleport)) {
    var_0D = getdamageaccumulator();
    if(isDefined(var_0D)) {
      if(var_1.cfastteleportduetodamagechance > 0 && var_0D.accumulateddamage > 0) {
        var_0E = var_0D.accumulateddamage / self.maxhealth;
        if(var_0E >= var_1.cfastteleportdamagepct) {
          cleardamageaccumulator();
          var_0F = randomint(100);
          if(var_0F < var_1.cfastteleportduetodamagechance) {
            var_3 = 1;
            self.findteleportposstatus = undefined;
          }
        }
      }
    }
  }

  if(!var_3) {
    self.nextteleporttesttime = var_2 + 250;
    self notify("Abort_FindTeleportPos");
    self.findteleportposstatus = undefined;
    return 0;
  }

  if(!scripts\engine\utility::flag("rk_fight_started")) {
    self.findteleportposstatus = "invalid";
  }

  if(!isDefined(self.findteleportposstatus)) {
    thread findteleportpos(scripts\mp\agents\ratking\ratking_agent::getenemy(), var_1.min_teleport_dist_to_player, var_1.max_teleport_dist_to_player, var_1.telefrag_dist_sq, var_1);
    return 0;
  }

  if(self.findteleportposstatus == "working") {
    return 0;
  }

  if(self.findteleportposstatus == "invalid") {
    self.findteleportposstatus = undefined;
    var_10 = findteleportposinfrontofenemy();
    if(isDefined(var_10)) {
      var_0C = scripts\mp\agents\ratking\ratking_agent::getenemy();
      if(!isDefined(var_0C)) {
        return 0;
      }

      var_11 = self findpath(var_10, var_0C.origin);
      if(!isDefined(var_11) || var_11.size < 2) {
        return 0;
      }

      var_12 = distance(var_10, var_0C.origin);
      var_4 = calcpathdist(var_11);
      if(var_4 > var_12 * 3) {
        return 0;
      }

      self.teleportpos = var_10;
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

findteleportspotinenemyview(var_0, var_1) {
  var_2 = var_0.angles[1];
  var_3 = var_0.angles;
  var_4 = randomintrange(var_1.cfastteleportminangledelta, var_1.cfastteleportmaxangledelta);
  if(randomint(100) < 50) {
    var_4 = var_4 * -1;
  }

  var_5 = distance(self.origin, var_0.origin);
  var_6 = randomfloatrange(var_1.cfastteleportcloseindistpctmin, var_1.cfastteleportcloseindistpctmax);
  var_7 = var_5 * var_6;
  if(var_7 < var_1.cfastteleportmindisttoenemytoteleport) {
    var_7 = var_1.cfastteleportmindisttoenemytoteleport;
  }

  var_8 = angleclamp180(var_3[1] + var_4);
  var_9 = anglesToForward((0, var_8, 0));
  var_0A = var_0.origin + var_9 * var_7;
  var_0A = getclosestpointonnavmesh(var_0A, self);
  return var_0A;
}

cleardamageaccumulator() {
  self.damageaccumulator.accumulateddamage = 0;
  self.damageaccumulator.lastdamagetime = 0;
}

getdamageaccumulator() {
  if(!isDefined(self.damageaccumulator)) {
    self.damageaccumulator = spawnStruct();
    self.damageaccumulator.accumulateddamage = 0;
  }

  var_0 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  if(!isDefined(self.damageaccumulator.lastdamagetime) || gettime() > self.damageaccumulator.lastdamagetime + var_0.cdamageaccumulationcleartimems) {
    self.damageaccumulator.accumulateddamage = 0;
    self.damageaccumulator.lastdamagetime = 0;
  }

  if(self.damageaccumulator.accumulateddamage == 0) {
    return undefined;
  }

  return self.damageaccumulator;
}

findteleportpos(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self notify("Abort_FindTeleportPos");
  self endon("Abort_FindTeleportPos");
  if(!isDefined(var_0)) {
    self.findteleportposstatus = "invalid";
    return;
  }

  var_5 = getvalidteleportpoints();
  if(!isDefined(var_5)) {
    var_5 = [];
    foreach(var_7 in getnodearray("ratking_teleport", "targetname")) {
      var_5[var_5.size] = var_7.origin;
    }
  }

  if(var_5.size == 0) {
    self.findteleportposstatus = "invalid";
    return;
  }

  var_9 = rk_isonplatform() && rk_shouldbeonplatform();
  var_0A = var_0 getvelocity();
  if(!var_9) {
    self.findteleportposstatus = "working";
    if(length2d(var_0A) < 1) {
      self.findteleportposstatus = "failure";
      return;
    }
  }

  var_0B = vectornormalize(var_0A);
  var_0C = getclosestpointonnavmesh(var_0.origin);
  var_0D = [];
  var_0E = [];
  foreach(var_10 in var_5) {
    var_11 = distance2dsquared(var_10, var_0C);
    if(var_11 > var_1 * var_1 && var_11 < var_2 * var_2) {
      var_0E[var_0E.size] = var_10;
      if(!is_near_any_targets(var_10)) {
        var_0D[var_0D.size] = var_10;
      }
    }
  }

  if(var_0D.size == 0) {
    if(scripts\engine\utility::istrue(self.force_teleport)) {
      var_0D = var_0E;
    } else if(var_0E.size <= 0) {
      self.findteleportposstatus = "failure";
      return;
    } else {
      var_0D = var_0E;
    }
  }

  var_0D = scripts\engine\utility::array_randomize_objects(var_0D);
  foreach(var_10 in var_0D) {
    if(isDefined(level.pam_grier)) {
      var_11 = distancesquared(var_10, level.pam_grier.origin);
      if(var_11 < var_3) {
        continue;
      }
    }

    var_14 = getclosestpointonnavmesh(var_10);
    var_15 = distance(self.origin, var_14);
    if(var_15 < var_4.min_path_dist_for_teleport) {
      continue;
    }

    var_16 = self findpath(var_0C, var_14);
    if(!var_9) {
      if(!isDefined(var_16) || var_16.size < 2) {
        scripts\engine\utility::waitframe();
        continue;
      }

      opcode::OP_SetNewLocalVariableFieldCached0 = vectornormalize(var_16[1] - var_0C);
      opcode::OP_EvalSelfFieldVariable = vectordot(opcode::OP_SetNewLocalVariableFieldCached0, var_0B);
      if(opcode::OP_EvalSelfFieldVariable < 0.707) {
        scripts\engine\utility::waitframe();
        continue;
      }
    }

    opcode::OP_Return = calcpathdist(var_16);
    opcode::OP_CallBuiltin0 = distance(var_16[0], var_16[var_16.size - 1]);
    if(opcode::OP_Return > opcode::OP_CallBuiltin0 * 3) {
      scripts\engine\utility::waitframe();
      continue;
    }

    self.findteleportposstatus = "success";
    self.teleportpos = var_10;
    return;
  }

  self.teleporttospot = undefined;
  self.findteleportposstatus = "failure";
}

getvalidteleportpoints() {
  var_0 = undefined;
  var_1 = rk_isonplatform();
  var_2 = scripts\engine\utility::istrue(self.shouldbeonplatform);
  if(var_2) {
    self.teleporttospot = 1;
    var_0 = level.ratkingplatformteleportpoints;
  } else if(var_1) {
    if(var_2) {
      self.teleporttospot = 1;
      var_0 = level.ratkingplatformteleportpoints;
    } else {
      self.teleporttospot = undefined;
      var_0 = level.ratkingteleportpoints;
    }
  } else {
    self.teleporttospot = undefined;
    var_0 = level.ratkingteleportpoints;
  }

  return var_0;
}

calcpathdist(var_0) {
  var_1 = 0;
  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    var_1 = var_1 + distance(var_0[var_2], var_0[var_2 + 1]);
  }

  return var_1;
}

is_near_any_targets(var_0) {
  if(isDefined(level.active_eye_targets)) {
    var_1 = scripts\engine\utility::array_combine(level.players, level.active_eye_targets);
  } else {
    var_1 = level.players;
  }

  var_2 = 250000;
  foreach(var_4 in var_1) {
    if(isplayer(var_4)) {
      if(!isalive(var_4)) {
        continue;
      }

      if(var_4.ignoreme || isDefined(var_4.triggerportableradarping) && var_4.triggerportableradarping.ignoreme) {
        continue;
      }

      if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_4)) {
        continue;
      }
    }

    if(distancesquared(var_0, var_4.origin) < var_2) {
      return 1;
    }
  }

  return 0;
}

is_near_any_player(var_0) {
  var_1 = 90000;
  foreach(var_3 in level.players) {
    if(!isalive(var_3)) {
      continue;
    }

    if(var_3.ignoreme || isDefined(var_3.triggerportableradarping) && var_3.triggerportableradarping.ignoreme) {
      continue;
    }

    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_3)) {
      continue;
    }

    if(distancesquared(var_0, var_3.origin) < var_1) {
      return 1;
    }
  }

  return 0;
}

findteleportposinfrontofenemy() {
  var_0 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  var_1 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  var_2 = var_1.min_teleport_dist_to_player * var_1.min_teleport_dist_to_player;
  var_3 = var_1.max_teleport_dist_to_player * var_1.max_teleport_dist_to_player;
  var_4 = var_0 getvelocity();
  var_5 = length2d(var_4);
  if(var_5 < 1) {
    var_6 = anglesToForward(var_0.angles);
    var_7 = var_1.min_teleport_dist_to_player;
  } else {
    var_6 = vectornormalize(var_6);
    var_6 = var_6 * 1.1;
    var_7 = var_6 * 1.75;
  }

  var_8 = var_0.origin + var_6 * var_1.max_teleport_dist_to_player;
  var_9 = 0;
  var_0A = getrandomnavpoints(var_8, var_1.max_teleport_dist_to_player, 64, self);
  scripts\engine\utility::array_randomize(var_0A);
  foreach(var_0C in var_0A) {
    if(distance(self.origin, var_0C) < var_1.min_travel_dist_for_teleport) {
      continue;
    }

    var_0D = var_0C - var_0.origin;
    var_0E = length2dsquared(var_0D);
    if(var_0E < var_2) {
      continue;
    }

    if(var_0E > var_3) {
      continue;
    }

    var_0F = vectornormalize(var_0D);
    var_10 = vectordot(var_6, var_0F);
    if(var_10 < 0.707) {
      continue;
    }

    var_11 = var_0 findpath(var_0.origin, var_0C);
    if(var_11.size < 1) {
      continue;
    }

    var_12 = scripts\common\trace::create_default_contents(1);
    if(!scripts\common\trace::ray_trace_passed(var_0C, var_0 getEye(), self, var_12)) {
      var_9++;
      if(var_9 >= 10) {
        self.nextteleporttesttime = gettime() + 200;
        return undefined;
      }

      continue;
    }

    return var_0C;
  }

  return undefined;
}

shouldtrymelee() {
  return level.rat_king_toggles["melee_attack"];
}

shouldtrystomp() {
  if(!scripts\mp\agents\ratking\ratking_agent::rkhasstaff()) {
    return 0;
  }

  return level.rat_king_toggles["staff_stomp"];
}

shouldtrysummon() {
  if(!scripts\mp\agents\ratking\ratking_agent::rkhasstaff()) {
    return 0;
  }

  return level.rat_king_toggles["summon"];
}

shouldtrystaffprojectile() {
  if(!scripts\mp\agents\ratking\ratking_agent::rkhasstaff()) {
    return 0;
  }

  if(rk_isonplatform()) {
    return 0;
  }

  return level.rat_king_toggles["staff_projectile"];
}

shouldtryshieldattack() {
  return level.rat_king_toggles["shield_attack"];
}

shouldtryshieldattackatpos() {
  if(level.rat_king_toggles["shield_attack_spot"]) {
    if(scripts\cp\maps\cp_disco\rat_king_fight::canspawneyetarget()) {
      return 1;
    }

    return 0;
  }

  return 0;
}

shouldtryblock() {
  return level.rat_king_toggles["block"];
}

shouldtryteleport() {
  return level.rat_king_toggles["teleport"];
}

tryforcedteleport() {
  if(!scripts\engine\utility::istrue(self.force_teleport)) {
    return 0;
  }

  var_0 = getvalidteleportpoints();
  var_1 = scripts\engine\utility::array_randomize_objects(var_0);
  self.teleportpos = var_1[0];
  self.desiredaction = "teleport";
  return 1;
}

shouldtrytraversalteleport() {
  if(scripts\engine\utility::flag_exist("rk_fight_started") && scripts\engine\utility::flag("rk_fight_started")) {
    return 0;
  }

  return 1;
}

trytraversalteleport() {
  if(isDefined(self.nexttraversalteleporttesttime) && gettime() < self.nexttraversalteleporttesttime) {
    return 0;
  }

  if(isDefined(self.vehicle_getspawnerarray)) {
    var_0 = self pathdisttogoal();
    var_1 = self func_84F9(var_0);
    if(isDefined(var_1)) {
      var_2 = var_1["node"];
      var_3 = var_1["position"];
      var_4 = var_2.opcode::OP_ScriptMethodCallPointer;
      if(isDefined(var_4)) {
        var_5 = self.asmname;
        var_6 = level.asm[var_5];
        var_7 = var_6.states[var_4];
        if(!isDefined(var_7)) {
          var_4 = "traverse_external";
        }

        if(var_4 == "traverse_external") {
          self.teleportpos = var_3;
          self.desiredaction = "teleport";
          return 1;
        }
      }
    }
  }

  return 0;
}

shouldtryattackzombies() {
  return level.rat_king_toggles["attack_zombies"];
}

decideaction(var_0) {
  if(tryforcedteleport()) {
    return level.success;
  }

  if(shouldtrytraversalteleport() && trytraversalteleport()) {
    return level.success;
  }

  var_1 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  if(!isDefined(var_1)) {
    return level.failure;
  }

  var_2 = gettime();
  if(var_2 - self.lastenemysighttime < 500) {
    var_3 = distancesquared(var_1.origin, self.origin);
    foreach(var_5 in level.rat_king_attack_priorities) {
      switch (var_5) {
        case "attack_zombies":
          if(shouldtryattackzombies() && tryattackzombies()) {
            return level.success;
          } else {
            break;
          }

          break;

        case "block":
          if(shouldtryblock() && tryblock()) {
            self.lastenemyengagetime = var_2;
            return level.success;
          } else {
            break;
          }

          break;

        case "melee_attack":
          if(shouldtrymelee() && trymeleeattacks(var_3)) {
            self.lastenemyengagetime = var_2;
            return level.success;
          } else {
            break;
          }

          break;

        case "staff_stomp":
          if(shouldtrystomp() && trymeleeattacks(var_3)) {
            self.lastenemyengagetime = var_2;
            return level.success;
          } else {
            break;
          }

          break;

        case "summon":
          if(shouldtrysummon() && trysummon(var_3)) {
            return level.success;
          } else {
            break;
          }

          break;

        case "staff_projectile":
          if(shouldtrystaffprojectile() && trystaffprojectile(var_3)) {
            self.lastenemyengagetime = var_2;
            return level.success;
          } else {
            break;
          }

          break;

        case "shield_attack":
          if(shouldtryshieldattack() && tryshieldattack(var_3)) {
            self.lastenemyengagetime = var_2;
            return level.success;
          } else {
            break;
          }

          break;

        case "shield_attack_spot":
          if(shouldtryshieldattackatpos() && tryshieldattackatpos(var_3)) {
            self.lastenemyengagetime = var_2;
            return level.success;
          } else {
            break;
          }

          break;

        case "teleport":
          if(shouldtryteleport() && tryteleport(var_3)) {
            self.lastenemyengagetime = var_2;
            return level.success;
          } else {
            break;
          }

          break;

        default:
          if(shouldtryteleport() && tryteleport()) {
            self.lastenemyengagetime = var_2;
            return level.success;
          } else {
            break;
          }

          break;
      }
    }
  }

  return level.failure;
}

doaction_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].ratkingaction = self.desiredaction;
  var_1 = self.actions[self.desiredaction].fnbegin;
  self.desiredaction = undefined;
  if(isDefined(var_1)) {
    [[var_1]](var_0);
  }
}

doaction_tick(var_0) {
  var_1 = getcurrentdesiredaction(var_0);
  if(var_1 != "debug_handler") {
    var_2 = scripts\mp\agents\ratking\ratking_agent::getenemy();
    if(!isDefined(var_2)) {
      return level.failure;
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
    doaction_end(var_0);
    doaction_begin(var_0);
    return level.running;
  }

  return level.failure;
}

doaction_end(var_0) {
  var_1 = getcurrentdesiredaction(var_0);
  var_2 = self.actions[var_1].fnend;
  if(isDefined(var_2)) {
    [[var_2]](var_0);
  }

  scripts\aitypes\ratking\bt_state_api::btstate_endstates(var_0);
  self.bt.instancedata[var_0] = undefined;
}

followenemy_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
}

followenemy_tick(var_0) {
  var_1 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  if(!isDefined(var_1)) {
    return level.failure;
  }

  var_2 = getclosestpointonnavmesh(var_1.origin, self);
  self ghostskulls_complete_status(var_2);
  return level.success;
}

followenemy_end(var_0) {
  self.bt.instancedata[var_0] = undefined;
}

rk_isonplatform() {
  if(scripts\engine\utility::istrue(self.isonplatform)) {
    return 1;
  }

  return 0;
}

rk_setonplatform(var_0) {
  self.isonplatform = var_0;
}

rk_shouldbeonplatform() {
  if(scripts\engine\utility::istrue(self.shouldbeonplatform)) {
    return 1;
  }

  return 0;
}

getrkstage() {
  return level.rat_king_stage;
}

bt_rk_isonplatform(var_0) {
  if(scripts\engine\utility::istrue(self.isonplatform)) {
    return level.success;
  }

  return level.failure;
}

setplatformstate() {
  if(scripts\engine\utility::istrue(self.teleporttospot)) {
    rk_setonplatform(1);
    self notify("teleport_to_platform");
    return;
  }

  rk_setonplatform(0);
}

togglerkhasstaff(var_0) {
  if(!isDefined(self.hasstaff) || self.hasstaff != var_0) {
    self.bstaffchanged = 1;
    self.hasstaff = var_0;
    self.nostaff = !var_0;
  }
}

rkdropshield() {
  self._blackboard.requestedshieldstate = "dropped";
}

rkthrowshield() {
  self._blackboard.requestedshieldstate = "thrown";
}

rkretrieveshield() {
  self._blackboard.requestedshieldstate = "equipped";
}

retrieveshieldaftertime(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("fake_death");
  self notify("retrieveShieldAfterTime");
  self endon("retrieveShieldAfterTime");
  if(scripts\mp\agents\ratking\ratking_agent::rkhasshield()) {
    self.remove_shield = 1;
    rkdropshield();
  }

  if(isDefined(var_0)) {
    wait(var_0);
  } else {
    wait(60);
  }

  rkretrieveshield();
  scripts\cp\maps\cp_disco\rat_king_fight::addblockcooldown(10000);
}

throwandrecovershield(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("fake_death");
  self notify("retrieveShieldAfterTime");
  self endon("retrieveShieldAfterTime");
  if(scripts\mp\agents\ratking\ratking_agent::rkhasshield()) {
    rkthrowshield();
  }

  if(isDefined(var_0)) {
    wait(var_0);
  } else {
    wait(60);
  }

  rkretrieveshield();
}

rkisstaffstomp() {
  var_0 = scripts\asm\asm::asm_getcurrentstate("ratking");
  if(var_0 == "staff_stomp") {
    return 1;
  }

  return 0;
}

rkisblocking() {
  var_0 = scripts\asm\asm::asm_getcurrentstate("ratking");
  if(isDefined(var_0) && var_0 == "block_intro" || var_0 == "block_loop") {
    return 1;
  }

  return 0;
}

rkissummoning() {
  var_0 = scripts\asm\asm::asm_getcurrentstate("ratking");
  if(isDefined(var_0) && var_0 == "summon") {
    return 1;
  }

  return 0;
}

retrievestaffaftertime(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("fake_death");
  self notify("retrieveStaffAfterTime");
  self endon("retrieveStaffAfterTime");
  if(scripts\mp\agents\ratking\ratking_agent::rkhasstaff()) {
    self.remove_staff = 1;
    togglerkhasstaff(0);
    self setscriptablepartstate("staff", "staff_dissolve");
  }

  if(isDefined(var_0)) {
    wait(var_0);
  } else {
    wait(60);
  }

  togglerkhasstaff(1);
  self setscriptablepartstate("staff", "staff_activate");
  scripts\cp\maps\cp_disco\rat_king_fight::addstaffstompcooldown(10000);
  scripts\cp\maps\cp_disco\rat_king_fight::addinnerstaffstompcooldown(10000);
  scripts\cp\maps\cp_disco\rat_king_fight::addstaffprojcooldown(10000);
}

shouldignoreenemy(var_0) {
  if(!isalive(var_0)) {
    return 1;
  }

  if(var_0.ignoreme || isDefined(var_0.triggerportableradarping) && var_0.triggerportableradarping.ignoreme) {
    return 1;
  }

  if(scripts\engine\utility::istrue(var_0.isfasttravelling)) {
    return 1;
  }

  if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_0)) {
    return 1;
  }

  return 0;
}