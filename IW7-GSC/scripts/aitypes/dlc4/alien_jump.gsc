/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\dlc4\alien_jump.gsc
***********************************************/

setupjumpattackbtaction(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = ::jumpattack_begin;
  }

  if(!isDefined(param_01)) {
    param_01 = ::jumpattack_tick;
  }

  if(!isDefined(param_02)) {
    param_02 = ::jumpattack_end;
  }

  scripts\aitypes\dlc4\bt_action_api::setupbtaction("jump_attack", ::jumpattack_begin, ::jumpattack_tick, ::jumpattack_end);
}

jumpattack_begin(param_00) {
  self.curmeleetarget = scripts\asm\dlc4\dlc4_asm::getenemy();
  scripts\aitypes\dlc4\behavior_utils::facepoint(self.var_AAFD);
  self.var_1198.jumpdestinationpos = self.var_AAFD;
  scripts\asm\dlc4\dlc4_asm::setasmaction("jump_attack");
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00, "jump_attack", "jump_attack");
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00, "jump_attack");
}

jumpattack_tick(param_00) {
  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  self clearpath();
  return level.success;
}

jumpattack_end(param_00) {
  var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self.curmeleetarget = undefined;
  self.nextjumpattack = gettime() + var_01.jump_attack_min_interval;
  self.var_1198.jumpdestinationpos = undefined;
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
}

func_7A7A(param_00, param_01, param_02, param_03) {
  var_04 = self.origin - param_02.origin;
  var_04 = var_04 * (1, 1, 0);
  var_04 = vectornormalize(var_04) * param_01;
  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  if(isplayer(param_02)) {
    var_05 = param_02 getvelocity();
    var_06 = 200;
    if(lengthsquared(var_05) > var_06 * var_06) {
      var_05 = vectornormalize(var_05);
      var_05 = var_05 * var_06;
    }

    var_05 = var_05 * param_03;
    var_05 = var_05 * param_00;
  } else {
    var_05 = (0, 0, 0);
  }

  return param_02.origin + var_04 + var_05;
}

tryjumpattack(param_00, param_01) {
  if(!isDefined(param_01)) {
    return 0;
  }

  var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  if(!isDefined(self.nextjumpattack)) {
    self.nextjumpattack = gettime() + var_02.jump_attack_initial_delay_ms;
    return 0;
  }

  if(gettime() < self.nextjumpattack) {
    return 0;
  }

  var_03 = vectornormalize(param_01.origin - self.origin * (1, 1, 0));
  var_04 = anglesToForward(self.angles);
  var_05 = vectordot(var_03, var_04);
  if(var_05 < var_02.jump_attack_min_enemy_dot) {
    return 0;
  }

  var_06 = distance2d(param_01.origin, self.origin);
  var_07 = var_06 / var_02.avg_leap_speed;
  var_08 = scripts\aitypes\dlc4\behavior_utils::getpredictedenemypos(param_01, var_07);
  var_06 = distance2d(var_08, self.origin);
  var_07 = var_06 / var_02.avg_leap_speed;
  var_09 = scripts\aitypes\dlc4\behavior_utils::getpredictedenemypos(param_01, var_07);
  var_0A = distancesquared(var_09, self.origin);
  if(var_0A < var_02.min_leap_distance_sq) {
    return 0;
  }

  self.nextjumpattack = gettime() + 150;
  var_09 = scripts\mp\agents\_scriptedagents::func_5D51(var_09, var_02.max_leap_melee_drop_distance);
  if(!isDefined(var_09)) {
    return 0;
  }

  var_0B = distancesquared(self.origin, var_09);
  if(var_0B < var_02.min_leap_distance_sq) {
    return 0;
  }

  if(var_0B > var_02.max_leap_distance_sq) {
    return 0;
  }

  var_0C = 0;
  var_0D = 1;
  if(var_02.teleport_chance != 0) {
    if(randomint(100) < var_02.teleport_chance) {
      if(var_0B >= var_02.min_dist_to_teleport_sq) {
        var_0C = 1;
        var_0E = navtrace(self.origin, var_09, self, 1);
        if(var_0E["fraction"] >= 0.9) {
          var_0D = 0;
        }
      }
    }
  }

  if(!self _meth_85CA(self.origin, var_09)) {
    return 0;
  }

  if(var_0D && !trajectorycanattemptaccuratejump(self.origin, anglestoup(self.angles), var_09, anglestoup(param_01.angles), level.var_1B73, 1.01 * level.var_1B74)) {
    return 0;
  }

  var_0F = getclosestpointonnavmesh(var_09, self);
  if(abs(var_0F[2] - var_09[2]) > 32) {
    return 0;
  }

  if(distance2dsquared(var_0F, var_09) > 144) {
    return 0;
  }

  self.var_AAFD = var_09;
  if(var_0C) {
    scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00, "teleport");
  } else {
    scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00, "jump_attack");
  }

  return 1;
}

jumpattack(param_00, param_01) {
  scripts\aitypes\dlc4\behavior_utils::facepoint(param_01);
  self.var_1198.jumpdestinationpos = param_01;
  scripts\asm\dlc4\dlc4_asm::setasmaction("jump_attack");
}