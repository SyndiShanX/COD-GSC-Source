/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\dlc4\dlc4_asm.gsc
*****************************************/

gettunedata() {
  return level.agenttunedata[self.agent_type];
}

getanimmovedeltadist(var_0) {
  var_1 = self getsafecircleorigin(var_0, 0);
  var_2 = getmovedelta(var_1, 0, 1);
  var_3 = length2d(var_2);
  return var_3;
}

analyzeanims() {
  var_0 = gettunedata();
  if(!isDefined(var_0.min_moving_pain_dist)) {
    var_1 = self getsafecircleorigin("pain_moving", 0);
    var_2 = getmovedelta(var_1, 0, 1);
    var_0.min_moving_pain_dist = length(var_2);
    var_0.arrivalanimdist = [];
    var_0.arrivalanimdist["run_stop"] = getanimmovedeltadist("run_stop");
    var_0.arrivalanimdist["sprint_stop"] = getanimmovedeltadist("sprint_stop");
    var_0.movingattackdisttoattack = [];
    var_3 = self getanimentrycount("moving_melee");
    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_1 = self getsafecircleorigin("moving_melee", var_4);
      var_5 = getnotetracktimes(var_1, "start_melee");
      var_2 = getmovedelta(var_1, 0, var_5[0]);
      var_0.movingattackdisttoattacksq[var_4] = length2dsquared(var_2);
    }
  }
}

choosespawnanim(var_0, var_1, var_2) {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_animation)) {
    var_3 = "";
    switch (self.synctransients) {
      case "walk":
      case "slow_walk":
        var_3 = "_walk";
        break;

      case "run":
      case "sprint":
        var_3 = "_run";
        break;

      default:
        break;
    }

    if(scripts\asm\asm_mp::func_2347(var_1, self.spawner.script_animation + var_3)) {
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.spawner.script_animation + var_3);
    } else if(scripts\asm\asm_mp::func_2347(var_1, self.spawner.script_animation)) {
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.spawner.script_animation);
    }
  }

  if(!isDefined(var_2)) {
    return lib_0F3C::func_3EF4(var_0, var_1, var_2);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
}

setasmaction(var_0) {
  if(isDefined(self.fnactionvalidator)) {}

  self.requested_action = var_0;
  self.current_action = undefined;
}

clearasmaction() {
  self.requested_action = undefined;
  self.current_action = undefined;
}

shoulddoaction(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.requested_action)) {
    return 0;
  }

  if(self.requested_action == var_2) {
    if(isDefined(self.current_action) && self.current_action == var_2) {
      return 0;
    }

    self.current_action = var_2;
    return 1;
  }

  return 0;
}

shouldabortaction(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.btraversalteleport)) {
    return 0;
  }

  if(!isDefined(self.requested_action)) {
    return 1;
  }

  if(isDefined(var_3)) {
    if(self.requested_action != var_3) {
      return 1;
    }
  }

  return 0;
}

playanimandlookatenemy(var_0, var_1, var_2, var_3) {
  thread scripts\asm\zombie\melee::func_6A6A(var_1, getenemy());
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, self.var_C081);
}

isanimdone(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::func_232B(var_1, "end")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(var_1, "early_end")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(var_1, "finish_early")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(var_1, "code_move")) {
    return 1;
  }

  return 0;
}

ismyenemyinfrontofme(var_0, var_1) {
  var_2 = vectornormalize(var_0.origin - self.origin * (1, 1, 0));
  var_3 = vectornormalize(anglesToForward(self.angles) * (1, 1, 0));
  var_4 = vectordot(var_2, var_3);
  if(var_4 > var_1) {
    return 1;
  }

  return 0;
}

shouldmeleeattackhit(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = self.origin;
  }

  if(scripts\mp\agents\zombie\zombie_util::func_9DE0(var_0)) {
    return 1;
  }

  var_5 = distance2dsquared(var_0.origin, var_4);
  if(var_5 > var_1) {
    return 0;
  }

  if(!ismyenemyinfrontofme(var_0, var_2)) {
    if(var_5 < var_3) {
      return 1;
    }

    return 0;
  }

  return 1;
}

domeleedamageoncontact(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_0 + "_finished");
  self endon("DoMeleeDamageOnContact_stop");
  var_5 = gettunedata();
  while(isDefined(var_1) && isalive(var_1)) {
    var_6 = self gettagorigin("j_head", 1);
    if(shouldmeleeattackhit(var_1, var_5.moving_melee_attack_damage_radius_sq, var_5.melee_dot, var_5.force_melee_attack_damage_radius_sq, var_6)) {
      scripts\asm\zombie\melee::func_1106E();
      scripts\asm\zombie\melee::domeleedamage(var_1, var_2, "MOD_IMPACT");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

alienmeleenotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    var_4 = gettunedata();
    if(shouldmeleeattackhit(self.curmeleetarget, var_4.moving_melee_attack_damage_radius_sq, var_4.melee_dot)) {
      scripts\asm\zombie\melee::func_1106E();
      scripts\asm\zombie\melee::domeleedamage(self.curmeleetarget, self.var_B601, "MOD_IMPACT");
    }
  }

  if(var_0 == "start_melee") {
    var_4 = gettunedata();
    thread domeleedamageoncontact(var_1, self.curmeleetarget, self.var_B601, var_4.moving_melee_attack_damage_radius_sq, var_4.melee_dot);
    return;
  }

  if(var_0 == "end_melee") {
    self scragentsetanimscale(1, 1);
    self notify("DoMeleeDamageOnContact_stop");
    return;
  }

  if(var_0 == "flex_start") {
    var_5 = getenemy();
    if(isDefined(var_5)) {
      var_4 = gettunedata();
      var_6 = self getsafecircleorigin(var_1, var_2);
      var_7 = getnotetracktimes(var_6, "hit");
      var_8 = var_7[0];
      if(var_8 > var_3) {
        var_9 = getmovedelta(var_6, var_3, var_8);
        var_0A = length2d(var_9);
        var_0B = getanimlength(var_6);
        var_0C = var_8 * var_0B - var_3 * var_0B;
        var_0D = var_5 getvelocity();
        var_0E = var_5.origin + var_0D * var_0C;
        var_0F = distance(var_0E, self.origin);
        var_10 = 1;
        if(var_0F > var_0A && var_0A > 0) {
          var_10 = var_0F / var_0A;
          if(var_10 < 1) {
            var_10 = 1;
          }

          var_10 = var_10 + var_4.melee_xy_scale_boost;
          if(var_10 > var_4.melee_max_flex_xy_scale) {
            var_10 = var_4.melee_max_flex_xy_scale;
          }
        } else {
          var_10 = 1 + var_4.melee_xy_scale_boost;
        }

        self scragentsetanimscale(var_10, 1);
        return;
      }

      return;
    }

    return;
  }
}

meleenotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    self scragentsetanimscale(1, 1);
    var_4 = getenemy();
    if(isDefined(var_4)) {
      var_5 = gettunedata();
      if(shouldmeleeattackhit(var_4, var_5.melee_attack_damage_radius_sq, var_5.melee_dot)) {
        self notify("attack_hit", var_4);
        scripts\asm\zombie\melee::domeleedamage(var_4, self.var_B601, "MOD_IMPACT");
      } else {
        self notify("attack_miss", var_4);
      }
    }

    if(!scripts\engine\utility::istrue(self.bmovingmelee)) {
      self notify("stop_melee_face_enemy");
    }
  }
}

terminate_movingmelee(var_0, var_1, var_2) {
  self _meth_85C9(0);
}

playanimwithplaybackrate(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = var_3;
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5, var_4);
}

stopfacingenemy(var_0, var_1) {
  self endon(var_0 + "_finished");
  wait(var_1);
  scripts\asm\zombie\melee::func_1106E();
}

choosemovingmeleeattack(var_0, var_1, var_2) {
  if(isDefined(self._blackboard.movingmeleeattackindex)) {
    return self._blackboard.movingmeleeattackindex;
  }

  return randomint(self getanimentrycount(var_1));
}

playmovingmeleeattack(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = 1;
  if(isDefined(self.var_C081)) {
    var_4 = self.var_C081;
  }

  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_6 = self getsafecircleorigin(var_1, var_5);
  var_7 = getanimlength(var_6) * 1 / var_4;
  var_8 = getnotetracktimes(var_6, "start_melee");
  var_9 = var_7 * var_8[0];
  var_0A = gettunedata();
  var_0B = randomfloatrange(var_0A.min_stop_facing_enemy_time_before_hit, var_0A.max_stop_facing_enemy_time_before_hit);
  var_0C = var_9 - var_0B;
  if(var_0C < 0) {
    var_0C = 0.1;
  }

  thread scripts\asm\zombie\melee::func_6A6A(var_1, self.curmeleetarget);
  thread stopfacingenemy(var_1, var_0C);
  if(isDefined(self.preventplayerpushdist)) {
    self _meth_85C9(self.preventplayerpushdist);
  }

  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5, var_4);
}

terminate_meleeattack(var_0, var_1, var_2) {
  self _meth_85C9(0);
}

playmeleeattack(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(var_1, self.curmeleetarget);
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  if(isDefined(self.preventplayerpushdist)) {
    self _meth_85C9(self.preventplayerpushdist);
  }

  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, self.var_C081);
}

choosemeleeattack(var_0, var_1, var_2) {
  self.meleeattackanimindex = randomintrange(0, self getanimentrycount(var_1));
  return self.meleeattackanimindex;
}

func_3EE4(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}

playmovingpainanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() < gettunedata().min_moving_pain_dist) {
    var_4 = func_3EE4(var_0, "pain_generic", var_3);
    self orientmode("face angle abs", self.angles);
    scripts\asm\asm_mp::func_2365(var_0, "pain_generic", var_2, var_4, self.var_C081);
    return;
  }

  var_4 = scripts\asm\asm_mp::asm_getanim(var_1, var_2);
  scripts\asm\asm_mp::func_2365(var_0, "pain_generic", var_2, var_4, self.var_C081);
}

doteleporthack(var_0, var_1, var_2, var_3) {
  var_6 = self _meth_8146();
  self setorigin(var_6, 0);
  var_6 = getgroundposition(var_6, 15);
  self.is_traversing = undefined;
  self notify("traverse_end");
  scripts\asm\asm::asm_setstate("decide_idle", var_3);
}

shouldturn(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.desiredyaw)) {
    return 0;
  }

  return 1;
}

handleadditionalyaw(var_0, var_1) {
  self endon(var_0 + "_finished");
  var_2 = self.additionalyaw / var_1;
  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = self.angles[1];
    var_4 = var_4 + var_2;
    var_5 = (self.angles[0], var_4, self.angles[2]);
    self orientmode("face angle abs", var_5);
    scripts\engine\utility::waitframe();
  }

  self.additionalyaw = undefined;
}

func_D56A(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self getsafecircleorigin(var_1, var_4);
  var_6 = getanimlength(var_5);
  if(isDefined(self.additionalyaw)) {
    thread handleadditionalyaw(var_1, floor(var_6 * 20));
  }

  return scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, self.var_C081);
}

func_3F0A(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = abs(self.desiredyaw);
  if(self.desiredyaw < 0) {
    if(var_4 < 67.5) {
      var_3 = 9;
    } else if(var_4 < 112.5) {
      var_3 = 6;
    } else if(var_4 < 157.5) {
      var_3 = 3;
    } else {
      var_3 = "2r";
    }
  } else if(self.desiredyaw < 67.5) {
    var_3 = 7;
  } else if(self.desiredyaw < 112.5) {
    var_3 = 4;
  } else if(self.desiredyaw < 157.5) {
    var_3 = 1;
  } else {
    var_3 = "2l";
  }

  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  var_6 = self getsafecircleorigin(var_1, var_5);
  var_7 = getangledelta(var_6, 0, 1);
  self.additionalyaw = self.desiredyaw - var_7;
  self.desiredyaw = undefined;
  return var_5;
}

shouldstartarrivalalien(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\zombie\zombie::func_FFE7()) {
    return 0;
  }

  var_4 = self.vehicle_getspawnerarray;
  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = gettunedata();
  if(!isDefined(var_5.arrivalanimdist[var_2])) {
    return 0;
  }

  var_6 = var_5.arrivalanimdist[var_2];
  var_7 = distance2d(var_4, self.origin);
  if(var_7 < var_6 * 1.1 && var_7 > var_6 * 0.75) {
    return 1;
  }

  return 0;
}

playalienarrival(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self.vehicle_getspawnerarray;
  if(isDefined(var_4)) {
    var_5 = gettunedata();
    var_6 = var_5.arrivalanimdist[var_1];
    var_7 = distance2d(var_4, self.origin);
    var_8 = var_7 / var_6;
    self scragentsetanimscale(var_8, 1);
  }

  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, 0, self.var_C081);
}

terminate_arrival(var_0, var_1, var_2) {
  self scragentsetanimscale(1, 1);
}

playaliendeathanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self gib_fx_override("gravity");
  if(!scripts\engine\utility::istrue(self.var_11B2F)) {
    self ghostlaunched("anim deltas");
  }

  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

getenemy() {
  if(isDefined(self.myenemy)) {
    return self.myenemy;
  }

  return undefined;
}

lookatenemy() {
  var_0 = getenemy();
  if(isDefined(var_0)) {
    var_1 = var_0.origin - self.origin;
    var_2 = vectortoangles(var_1);
    self orientmode("face angle abs", var_2);
    return;
  }

  self orientmode("face angle abs", self.angles);
}

dojump(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  if(self.agent_type == "alien_phantom") {
    self.bteleporting = 1;
  }

  if(isDefined(self.preventplayerpushdist)) {
    self _meth_85C9(self.preventplayerpushdist);
  }

  scripts\asm\alien_goon\alien_jump::func_A4C3(var_0, var_1, self.origin, self.angles, self._blackboard.jumpdestinationpos, self._blackboard.jumpdestinationangles, self._blackboard.jumpnextpos);
  self.bteleporting = undefined;
  self._blackboard.jumpdestinationpos = undefined;
  self._blackboard.jumpdestinationangles = undefined;
  self._blackboard.jumpnextpos = undefined;
  clearasmaction();
}

dojumpattack(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = gettunedata();
  thread domeleedamageoncontact(var_1, self.curmeleetarget, self.var_B601 * var_4.jump_attack_melee_damage_multiplier, var_4.jump_attack_damage_radius_sq, var_4.jump_attack_damage_dot);
  if(isDefined(self.preventplayerpushdist)) {
    self _meth_85C9(self.preventplayerpushdist);
  }

  scripts\asm\alien_goon\alien_jump::jumpattack(var_0, var_1, self._blackboard.jumpdestinationpos);
  self._blackboard.jumpdestinationpos = undefined;
  clearasmaction();
}

doalienjumptraversal(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self getspectatepoint();
  var_5 = self _meth_8146();
  var_6 = scripts\engine\utility::getyawtospot(var_5);
  if(abs(var_6) > 16) {
    self.desiredyaw = var_6;
    func_D56A(var_0, "turn", var_2);
  }

  var_7 = vectornormalize(var_5 - self.origin * (1, 1, 0));
  var_8 = vectortoangles(var_7);
  if(self.agent_type == "alien_phantom") {
    self.bteleporting = 1;
  }

  scripts\asm\alien_goon\alien_jump::func_A4C3(var_0, var_1, self.origin, var_8, var_5, var_8, var_5 + anglesToForward(var_8) * 10);
  self.bteleporting = undefined;
  self notify("traverse_end");
  thread scripts\asm\asm::asm_setstate("decide_idle");
}

checkpainnotify() {
  if(self._blackboard.painnotifytime > 0) {
    self._blackboard.painnotifytime = 0;
    return 1;
  }

  return 0;
}

jumpnotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "stop_teleport") {
    if(self isethereal()) {
      level.totalphantomsjumping--;
      if(level.totalphantomsjumping <= 0) {
        level.totalphantomsjumping = 0;
      }

      self setethereal(0);
      thread play_teleport_end();
    }
  }
}

play_teleport_end() {
  scripts\engine\utility::waitframe();
  self setscriptablepartstate("teleport_fx", "teleport_end");
}

terminate_jump(var_0, var_1, var_2) {
  self setethereal(0);
}

isalienjumpfinished(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.var_11B2F)) {
    return 0;
  }

  return shouldabortaction(var_0, var_1, var_2, var_1);
}