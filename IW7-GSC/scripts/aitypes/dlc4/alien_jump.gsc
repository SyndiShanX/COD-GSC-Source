/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\aitypes\dlc4\alien_jump.gsc
***********************************************/

setupjumpattackbtaction(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = ::jumpattack_begin;
  }

  if(!isDefined(var_1)) {
    var_1 = ::jumpattack_tick;
  }

  if(!isDefined(var_2)) {
    var_2 = ::jumpattack_end;
  }

  scripts\aitypes\dlc4\bt_action_api::setupbtaction("jump_attack", ::jumpattack_begin, ::jumpattack_tick, ::jumpattack_end);
}

jumpattack_begin(var_0) {
  self.curmeleetarget = scripts\asm\dlc4\dlc4_asm::getenemy();
  scripts\aitypes\dlc4\behavior_utils::facepoint(self.var_AAFD);
  self._blackboard.jumpdestinationpos = self.var_AAFD;
  scripts\asm\dlc4\dlc4_asm::setasmaction("jump_attack");
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "jump_attack", "jump_attack");
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "jump_attack");
}

jumpattack_tick(var_0) {
  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  self clearpath();
  return level.success;
}

jumpattack_end(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self.curmeleetarget = undefined;
  self.nextjumpattack = gettime() + var_1.jump_attack_min_interval;
  self._blackboard.jumpdestinationpos = undefined;
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
}

func_7A7A(var_0, var_1, var_2, var_3) {
  var_4 = self.origin - var_2.origin;
  var_4 = var_4 * (1, 1, 0);
  var_4 = vectornormalize(var_4) * var_1;
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(isplayer(var_2)) {
    var_5 = var_2 getvelocity();
    var_6 = 200;
    if(lengthsquared(var_5) > var_6 * var_6) {
      var_5 = vectornormalize(var_5);
      var_5 = var_5 * var_6;
    }

    var_5 = var_5 * var_3;
    var_5 = var_5 * var_0;
  } else {
    var_5 = (0, 0, 0);
  }

  return var_2.origin + var_4 + var_5;
}

tryjumpattack(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  if(!isDefined(self.nextjumpattack)) {
    self.nextjumpattack = gettime() + var_2.jump_attack_initial_delay_ms;
    return 0;
  }

  if(gettime() < self.nextjumpattack) {
    return 0;
  }

  var_3 = vectornormalize(var_1.origin - self.origin * (1, 1, 0));
  var_4 = anglesToForward(self.angles);
  var_5 = vectordot(var_3, var_4);
  if(var_5 < var_2.jump_attack_min_enemy_dot) {
    return 0;
  }

  var_6 = distance2d(var_1.origin, self.origin);
  var_7 = var_6 / var_2.avg_leap_speed;
  var_8 = scripts\aitypes\dlc4\behavior_utils::getpredictedenemypos(var_1, var_7);
  var_6 = distance2d(var_8, self.origin);
  var_7 = var_6 / var_2.avg_leap_speed;
  var_9 = scripts\aitypes\dlc4\behavior_utils::getpredictedenemypos(var_1, var_7);
  var_0A = distancesquared(var_9, self.origin);
  if(var_0A < var_2.min_leap_distance_sq) {
    return 0;
  }

  self.nextjumpattack = gettime() + 150;
  var_9 = scripts\mp\agents\_scriptedagents::func_5D51(var_9, var_2.max_leap_melee_drop_distance);
  if(!isDefined(var_9)) {
    return 0;
  }

  var_0B = distancesquared(self.origin, var_9);
  if(var_0B < var_2.min_leap_distance_sq) {
    return 0;
  }

  if(var_0B > var_2.max_leap_distance_sq) {
    return 0;
  }

  var_0C = 0;
  var_0D = 1;
  if(var_2.teleport_chance != 0) {
    if(randomint(100) < var_2.teleport_chance) {
      if(var_0B >= var_2.min_dist_to_teleport_sq) {
        var_0C = 1;
        var_0E = navtrace(self.origin, var_9, self, 1);
        if(var_0E["fraction"] >= 0.9) {
          var_0D = 0;
        }
      }
    }
  }

  if(!self _meth_85CA(self.origin, var_9)) {
    return 0;
  }

  if(var_0D && !trajectorycanattemptaccuratejump(self.origin, anglestoup(self.angles), var_9, anglestoup(var_1.angles), level.var_1B73, 1.01 * level.var_1B74)) {
    return 0;
  }

  var_0F = getclosestpointonnavmesh(var_9, self);
  if(abs(var_0F[2] - var_9[2]) > 32) {
    return 0;
  }

  if(distance2dsquared(var_0F, var_9) > 144) {
    return 0;
  }

  self.var_AAFD = var_9;
  if(var_0C) {
    scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "teleport");
  } else {
    scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "jump_attack");
  }

  return 1;
}

jumpattack(var_0, var_1) {
  scripts\aitypes\dlc4\behavior_utils::facepoint(var_1);
  self._blackboard.jumpdestinationpos = var_1;
  scripts\asm\dlc4\dlc4_asm::setasmaction("jump_attack");
}