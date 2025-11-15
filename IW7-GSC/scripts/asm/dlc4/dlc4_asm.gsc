/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\dlc4\dlc4_asm.gsc
*****************************************/

gettunedata() {
  return level.agenttunedata[self.agent_type];
}

getanimmovedeltadist(param_00) {
  var_01 = self getsafecircleorigin(param_00, 0);
  var_02 = getmovedelta(var_01, 0, 1);
  var_03 = length2d(var_02);
  return var_03;
}

analyzeanims() {
  var_00 = gettunedata();
  if(!isDefined(var_00.min_moving_pain_dist)) {
    var_01 = self getsafecircleorigin("pain_moving", 0);
    var_02 = getmovedelta(var_01, 0, 1);
    var_00.min_moving_pain_dist = length(var_02);
    var_00.arrivalanimdist = [];
    var_00.arrivalanimdist["run_stop"] = getanimmovedeltadist("run_stop");
    var_00.arrivalanimdist["sprint_stop"] = getanimmovedeltadist("sprint_stop");
    var_00.movingattackdisttoattack = [];
    var_03 = self getanimentrycount("moving_melee");
    for(var_04 = 0; var_04 < var_03; var_04++) {
      var_01 = self getsafecircleorigin("moving_melee", var_04);
      var_05 = getnotetracktimes(var_01, "start_melee");
      var_02 = getmovedelta(var_01, 0, var_05[0]);
      var_00.movingattackdisttoattacksq[var_04] = length2dsquared(var_02);
    }
  }
}

choosespawnanim(param_00, param_01, param_02) {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_animation)) {
    var_03 = "";
    switch (self.synctransients) {
      case "walk":
      case "slow_walk":
        var_03 = "_walk";
        break;

      case "run":
      case "sprint":
        var_03 = "_run";
        break;

      default:
        break;
    }

    if(scripts\asm\asm_mp::func_2347(param_01, self.spawner.script_animation + var_03)) {
      return scripts\asm\asm::asm_lookupanimfromalias(param_01, self.spawner.script_animation + var_03);
    } else if(scripts\asm\asm_mp::func_2347(param_01, self.spawner.script_animation)) {
      return scripts\asm\asm::asm_lookupanimfromalias(param_01, self.spawner.script_animation);
    }
  }

  if(!isDefined(param_02)) {
    return lib_0F3C::func_3EF4(param_00, param_01, param_02);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, param_02);
}

setasmaction(param_00) {
  if(isDefined(self.fnactionvalidator)) {}

  self.requested_action = param_00;
  self.current_action = undefined;
}

clearasmaction() {
  self.requested_action = undefined;
  self.current_action = undefined;
}

shoulddoaction(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.requested_action)) {
    return 0;
  }

  if(self.requested_action == param_02) {
    if(isDefined(self.current_action) && self.current_action == param_02) {
      return 0;
    }

    self.current_action = param_02;
    return 1;
  }

  return 0;
}

shouldabortaction(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.btraversalteleport)) {
    return 0;
  }

  if(!isDefined(self.requested_action)) {
    return 1;
  }

  if(isDefined(param_03)) {
    if(self.requested_action != param_03) {
      return 1;
    }
  }

  return 0;
}

playanimandlookatenemy(param_00, param_01, param_02, param_03) {
  thread scripts\asm\zombie\melee::func_6A6A(param_01, getenemy());
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, self.var_C081);
}

isanimdone(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm::func_232B(param_01, "end")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(param_01, "early_end")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(param_01, "finish_early")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(param_01, "code_move")) {
    return 1;
  }

  return 0;
}

ismyenemyinfrontofme(param_00, param_01) {
  var_02 = vectornormalize(param_00.origin - self.origin * (1, 1, 0));
  var_03 = vectornormalize(anglesToForward(self.angles) * (1, 1, 0));
  var_04 = vectordot(var_02, var_03);
  if(var_04 > param_01) {
    return 1;
  }

  return 0;
}

shouldmeleeattackhit(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!isDefined(param_04)) {
    param_04 = self.origin;
  }

  if(scripts\mp\agents\zombie\zombie_util::func_9DE0(param_00)) {
    return 1;
  }

  var_05 = distance2dsquared(param_00.origin, param_04);
  if(var_05 > param_01) {
    return 0;
  }

  if(!ismyenemyinfrontofme(param_00, param_02)) {
    if(var_05 < param_03) {
      return 1;
    }

    return 0;
  }

  return 1;
}

domeleedamageoncontact(param_00, param_01, param_02, param_03, param_04) {
  self endon(param_00 + "_finished");
  self endon("DoMeleeDamageOnContact_stop");
  var_05 = gettunedata();
  while(isDefined(param_01) && isalive(param_01)) {
    var_06 = self gettagorigin("j_head", 1);
    if(shouldmeleeattackhit(param_01, var_05.moving_melee_attack_damage_radius_sq, var_05.melee_dot, var_05.force_melee_attack_damage_radius_sq, var_06)) {
      scripts\asm\zombie\melee::func_1106E();
      scripts\asm\zombie\melee::domeleedamage(param_01, param_02, "MOD_IMPACT");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

alienmeleenotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    var_04 = gettunedata();
    if(shouldmeleeattackhit(self.curmeleetarget, var_04.moving_melee_attack_damage_radius_sq, var_04.melee_dot)) {
      scripts\asm\zombie\melee::func_1106E();
      scripts\asm\zombie\melee::domeleedamage(self.curmeleetarget, self.var_B601, "MOD_IMPACT");
    }
  }

  if(param_00 == "start_melee") {
    var_04 = gettunedata();
    thread domeleedamageoncontact(param_01, self.curmeleetarget, self.var_B601, var_04.moving_melee_attack_damage_radius_sq, var_04.melee_dot);
    return;
  }

  if(param_00 == "end_melee") {
    self scragentsetanimscale(1, 1);
    self notify("DoMeleeDamageOnContact_stop");
    return;
  }

  if(param_00 == "flex_start") {
    var_05 = getenemy();
    if(isDefined(var_05)) {
      var_04 = gettunedata();
      var_06 = self getsafecircleorigin(param_01, param_02);
      var_07 = getnotetracktimes(var_06, "hit");
      var_08 = var_07[0];
      if(var_08 > param_03) {
        var_09 = getmovedelta(var_06, param_03, var_08);
        var_0A = length2d(var_09);
        var_0B = getanimlength(var_06);
        var_0C = var_08 * var_0B - param_03 * var_0B;
        var_0D = var_05 getvelocity();
        var_0E = var_05.origin + var_0D * var_0C;
        var_0F = distance(var_0E, self.origin);
        var_10 = 1;
        if(var_0F > var_0A && var_0A > 0) {
          var_10 = var_0F / var_0A;
          if(var_10 < 1) {
            var_10 = 1;
          }

          var_10 = var_10 + var_04.melee_xy_scale_boost;
          if(var_10 > var_04.melee_max_flex_xy_scale) {
            var_10 = var_04.melee_max_flex_xy_scale;
          }
        } else {
          var_10 = 1 + var_04.melee_xy_scale_boost;
        }

        self scragentsetanimscale(var_10, 1);
        return;
      }

      return;
    }

    return;
  }
}

meleenotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    self scragentsetanimscale(1, 1);
    var_04 = getenemy();
    if(isDefined(var_04)) {
      var_05 = gettunedata();
      if(shouldmeleeattackhit(var_04, var_05.melee_attack_damage_radius_sq, var_05.melee_dot)) {
        self notify("attack_hit", var_04);
        scripts\asm\zombie\melee::domeleedamage(var_04, self.var_B601, "MOD_IMPACT");
      } else {
        self notify("attack_miss", var_04);
      }
    }

    if(!scripts\engine\utility::istrue(self.bmovingmelee)) {
      self notify("stop_melee_face_enemy");
    }
  }
}

terminate_movingmelee(param_00, param_01, param_02) {
  self _meth_85C9(0);
}

playanimwithplaybackrate(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = param_03;
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_05, var_04);
}

stopfacingenemy(param_00, param_01) {
  self endon(param_00 + "_finished");
  wait(param_01);
  scripts\asm\zombie\melee::func_1106E();
}

choosemovingmeleeattack(param_00, param_01, param_02) {
  if(isDefined(self.var_1198.movingmeleeattackindex)) {
    return self.var_1198.movingmeleeattackindex;
  }

  return randomint(self getanimentrycount(param_01));
}

playmovingmeleeattack(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = 1;
  if(isDefined(self.var_C081)) {
    var_04 = self.var_C081;
  }

  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_06 = self getsafecircleorigin(param_01, var_05);
  var_07 = getanimlength(var_06) * 1 / var_04;
  var_08 = getnotetracktimes(var_06, "start_melee");
  var_09 = var_07 * var_08[0];
  var_0A = gettunedata();
  var_0B = randomfloatrange(var_0A.min_stop_facing_enemy_time_before_hit, var_0A.max_stop_facing_enemy_time_before_hit);
  var_0C = var_09 - var_0B;
  if(var_0C < 0) {
    var_0C = 0.1;
  }

  thread scripts\asm\zombie\melee::func_6A6A(param_01, self.curmeleetarget);
  thread stopfacingenemy(param_01, var_0C);
  if(isDefined(self.preventplayerpushdist)) {
    self _meth_85C9(self.preventplayerpushdist);
  }

  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_05, var_04);
}

terminate_meleeattack(param_00, param_01, param_02) {
  self _meth_85C9(0);
}

playmeleeattack(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(param_01, self.curmeleetarget);
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  if(isDefined(self.preventplayerpushdist)) {
    self _meth_85C9(self.preventplayerpushdist);
  }

  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, self.var_C081);
}

choosemeleeattack(param_00, param_01, param_02) {
  self.meleeattackanimindex = randomintrange(0, self getanimentrycount(param_01));
  return self.meleeattackanimindex;
}

func_3EE4(param_00, param_01, param_02) {
  return lib_0F3C::func_3EF4(param_00, param_01, param_02);
}

playmovingpainanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() < gettunedata().min_moving_pain_dist) {
    var_04 = func_3EE4(param_00, "pain_generic", param_03);
    self orientmode("face angle abs", self.angles);
    scripts\asm\asm_mp::func_2365(param_00, "pain_generic", param_02, var_04, self.var_C081);
    return;
  }

  var_04 = scripts\asm\asm_mp::asm_getanim(param_01, param_02);
  scripts\asm\asm_mp::func_2365(param_00, "pain_generic", param_02, var_04, self.var_C081);
}

doteleporthack(param_00, param_01, param_02, param_03) {
  var_06 = self _meth_8146();
  self setorigin(var_06, 0);
  var_06 = getgroundposition(var_06, 15);
  self.is_traversing = undefined;
  self notify("traverse_end");
  scripts\asm\asm::asm_setstate("decide_idle", param_03);
}

shouldturn(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.desiredyaw)) {
    return 0;
  }

  return 1;
}

handleadditionalyaw(param_00, param_01) {
  self endon(param_00 + "_finished");
  var_02 = self.additionalyaw / param_01;
  for(var_03 = 0; var_03 < param_01; var_03++) {
    var_04 = self.angles[1];
    var_04 = var_04 + var_02;
    var_05 = (self.angles[0], var_04, self.angles[2]);
    self orientmode("face angle abs", var_05);
    scripts\engine\utility::waitframe();
  }

  self.additionalyaw = undefined;
}

func_D56A(param_00, param_01, param_02, param_03) {
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = self getsafecircleorigin(param_01, var_04);
  var_06 = getanimlength(var_05);
  if(isDefined(self.additionalyaw)) {
    thread handleadditionalyaw(param_01, floor(var_06 * 20));
  }

  return scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, self.var_C081);
}

func_3F0A(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = abs(self.desiredyaw);
  if(self.desiredyaw < 0) {
    if(var_04 < 67.5) {
      var_03 = 9;
    } else if(var_04 < 112.5) {
      var_03 = 6;
    } else if(var_04 < 157.5) {
      var_03 = 3;
    } else {
      var_03 = "2r";
    }
  } else if(self.desiredyaw < 67.5) {
    var_03 = 7;
  } else if(self.desiredyaw < 112.5) {
    var_03 = 4;
  } else if(self.desiredyaw < 157.5) {
    var_03 = 1;
  } else {
    var_03 = "2l";
  }

  var_05 = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
  var_06 = self getsafecircleorigin(param_01, var_05);
  var_07 = getangledelta(var_06, 0, 1);
  self.additionalyaw = self.desiredyaw - var_07;
  self.desiredyaw = undefined;
  return var_05;
}

shouldstartarrivalalien(param_00, param_01, param_02, param_03) {
  if(!scripts\asm\zombie\zombie::func_FFE7()) {
    return 0;
  }

  var_04 = self.vehicle_getspawnerarray;
  if(!isDefined(var_04)) {
    return 0;
  }

  var_05 = gettunedata();
  if(!isDefined(var_05.arrivalanimdist[param_02])) {
    return 0;
  }

  var_06 = var_05.arrivalanimdist[param_02];
  var_07 = distance2d(var_04, self.origin);
  if(var_07 < var_06 * 1.1 && var_07 > var_06 * 0.75) {
    return 1;
  }

  return 0;
}

playalienarrival(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = self.vehicle_getspawnerarray;
  if(isDefined(var_04)) {
    var_05 = gettunedata();
    var_06 = var_05.arrivalanimdist[param_01];
    var_07 = distance2d(var_04, self.origin);
    var_08 = var_07 / var_06;
    self scragentsetanimscale(var_08, 1);
  }

  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, 0, self.var_C081);
}

terminate_arrival(param_00, param_01, param_02) {
  self scragentsetanimscale(1, 1);
}

playaliendeathanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self gib_fx_override("gravity");
  if(!scripts\engine\utility::istrue(self.var_11B2F)) {
    self ghostlaunched("anim deltas");
  }

  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

getenemy() {
  if(isDefined(self.myenemy)) {
    return self.myenemy;
  }

  return undefined;
}

lookatenemy() {
  var_00 = getenemy();
  if(isDefined(var_00)) {
    var_01 = var_00.origin - self.origin;
    var_02 = vectortoangles(var_01);
    self orientmode("face angle abs", var_02);
    return;
  }

  self orientmode("face angle abs", self.angles);
}

dojump(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  if(self.agent_type == "alien_phantom") {
    self.bteleporting = 1;
  }

  if(isDefined(self.preventplayerpushdist)) {
    self _meth_85C9(self.preventplayerpushdist);
  }

  scripts\asm\alien_goon\alien_jump::func_A4C3(param_00, param_01, self.origin, self.angles, self.var_1198.jumpdestinationpos, self.var_1198.jumpdestinationangles, self.var_1198.jumpnextpos);
  self.bteleporting = undefined;
  self.var_1198.jumpdestinationpos = undefined;
  self.var_1198.jumpdestinationangles = undefined;
  self.var_1198.jumpnextpos = undefined;
  clearasmaction();
}

dojumpattack(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = gettunedata();
  thread domeleedamageoncontact(param_01, self.curmeleetarget, self.var_B601 * var_04.jump_attack_melee_damage_multiplier, var_04.jump_attack_damage_radius_sq, var_04.jump_attack_damage_dot);
  if(isDefined(self.preventplayerpushdist)) {
    self _meth_85C9(self.preventplayerpushdist);
  }

  scripts\asm\alien_goon\alien_jump::jumpattack(param_00, param_01, self.var_1198.jumpdestinationpos);
  self.var_1198.jumpdestinationpos = undefined;
  clearasmaction();
}

doalienjumptraversal(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = self getspectatepoint();
  var_05 = self _meth_8146();
  var_06 = scripts\engine\utility::getyawtospot(var_05);
  if(abs(var_06) > 16) {
    self.desiredyaw = var_06;
    func_D56A(param_00, "turn", param_02);
  }

  var_07 = vectornormalize(var_05 - self.origin * (1, 1, 0));
  var_08 = vectortoangles(var_07);
  if(self.agent_type == "alien_phantom") {
    self.bteleporting = 1;
  }

  scripts\asm\alien_goon\alien_jump::func_A4C3(param_00, param_01, self.origin, var_08, var_05, var_08, var_05 + anglesToForward(var_08) * 10);
  self.bteleporting = undefined;
  self notify("traverse_end");
  thread scripts\asm\asm::asm_setstate("decide_idle");
}

checkpainnotify() {
  if(self.var_1198.painnotifytime > 0) {
    self.var_1198.painnotifytime = 0;
    return 1;
  }

  return 0;
}

jumpnotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "stop_teleport") {
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

terminate_jump(param_00, param_01, param_02) {
  self setethereal(0);
}

isalienjumpfinished(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.var_11B2F)) {
    return 0;
  }

  return shouldabortaction(param_00, param_01, param_02, param_01);
}