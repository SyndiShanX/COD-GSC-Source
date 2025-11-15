/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\crab_mini\crab_mini_asm.gsc
***************************************************/

asminit(param_00, param_01, param_02, param_03) {
  scripts\asm\zombie\zombie::func_13F9A(param_00, param_01, param_02, param_03);
  analyzeanims();
}

analyzeanims() {
  var_00 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
  if(!isDefined(var_00.min_moving_pain_dist)) {
    var_01 = self getsafecircleorigin("pain_moving", 0);
    var_02 = getmovedelta(var_01, 0, 1);
    var_00.min_moving_pain_dist = length(var_02);
  }
}

isvalidaction(param_00) {
  switch (param_00) {
    case "moving_melee":
    case "stand_melee":
      return 1;
  }

  return 0;
}

setaction(param_00) {
  self.requested_action = param_00;
}

clearaction() {
  self.requested_action = undefined;
}

shouldplayentranceanim(param_00, param_01, param_02, param_03) {
  return 1;
}

playanimandlookatenemy(param_00, param_01, param_02, param_03) {
  thread scripts\asm\zombie\melee::func_6A6A(param_01, scripts\mp\agents\crab_mini\crab_mini_agent::getenemy());
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, 1);
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
  var_03 = anglesToForward(self.angles);
  var_04 = vectordot(var_02, var_03);
  if(var_04 > param_01) {
    return 1;
  }

  return 0;
}

shouldmeleeattackhit(param_00, param_01, param_02) {
  if(scripts\mp\agents\zombie\zombie_util::func_9DE0(param_00)) {
    return 1;
  }

  var_03 = distance2dsquared(param_00.origin, self.origin);
  if(var_03 > param_01) {
    return 0;
  }

  if(!ismyenemyinfrontofme(param_00, param_02)) {
    return 0;
  }

  return 1;
}

playmovingmelee(param_00, param_01, param_02, param_03) {
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

domeleedamageoncontact(param_00, param_01) {
  self endon(param_00 + "_finished");
  self endon("DoMeleeDamageOnContact_stop");
  var_02 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
  while(isDefined(param_01) && isalive(param_01)) {
    if(shouldmeleeattackhit(param_01, var_02.moving_melee_attack_damage_radius_sq, var_02.melee_dot)) {
      if(randomint(100) < var_02.chance_to_get_stuck_if_hit) {
        scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(1);
      } else {
        scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(0);
      }

      scripts\asm\zombie\melee::func_1106E();
      scripts\asm\zombie\melee::domeleedamage(param_01, self.var_B601, "MOD_IMPACT");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

movingmeleenotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    self scragentsetanimscale(1, 1);
    self notify("DoMeleeDamageOnContact_stop");
    return;
  }

  if(param_00 == "flex_start") {
    var_04 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
    if(isDefined(var_04)) {
      var_05 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
      var_06 = self getsafecircleorigin(param_01, param_02);
      var_07 = getnotetracktimes(var_06, "hit");
      var_08 = var_07[0];
      if(var_08 > param_03) {
        var_09 = getmovedelta(var_06, param_03, var_08);
        var_0A = length2d(var_09);
        var_0B = getanimlength(var_06);
        var_0C = var_08 * var_0B - param_03 * var_0B;
        var_0D = var_04 getvelocity();
        var_0E = var_04.origin + var_0D * var_0C;
        var_0F = distance(var_0E, self.origin);
        var_10 = 1;
        if(var_0F > var_0A && var_0A > 0) {
          var_10 = var_0F / var_0A;
          if(var_10 < 1) {
            var_10 = 1;
          }

          var_10 = var_10 + var_05.melee_xy_scale_boost;
          if(var_10 > var_05.melee_max_flex_xy_scale) {
            var_10 = var_05.melee_max_flex_xy_scale;
          }
        } else {
          var_10 = 1 + var_05.melee_xy_scale_boost;
        }

        self scragentsetanimscale(var_10, 1);
        return;
      }

      return;
    }

    return;
  }

  if(var_0C == "check_stuck") {
    if(scripts\mp\agents\crab_mini\crab_mini_agent::iscrabministuck()) {
      scripts\asm\asm::asm_fireevent(var_0D, "end");
      return;
    }

    return;
  }
}

meleenotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    self scragentsetanimscale(1, 1);
    var_04 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
    if(isDefined(var_04)) {
      var_05 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
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

timetogetstuck(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.btimetogetstuck)) {
    self.btimetogetstuck = undefined;
    return 1;
  }

  return 0;
}

terminate_movingmelee(param_00, param_01, param_02) {
  self.btimetogetstuck = undefined;
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

shoulddoaction(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.requested_action)) {
    return 0;
  }

  if(self.requested_action == param_02) {
    return 1;
  }

  return 0;
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

playmovingmeleeattack(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = self getsafecircleorigin(param_01, var_04);
  var_06 = getanimlength(var_05);
  var_07 = getnotetracktimes(var_05, "hit");
  var_08 = var_06 * var_07[0];
  var_09 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
  var_0A = randomfloatrange(var_09.min_stop_facing_enemy_time_before_hit, var_09.max_stop_facing_enemy_time_before_hit);
  var_0B = var_08 - var_0A;
  if(var_0B < 0) {
    var_0B = 0.1;
  }

  if(randomint(100) < var_09.chance_to_get_stuck_if_miss) {
    scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(1);
  } else {
    scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(0);
  }

  thread scripts\asm\zombie\melee::func_6A6A(param_01, self.curmeleetarget);
  thread stopfacingenemy(param_01, var_0B);
  thread domeleedamageoncontact(param_01, self.curmeleetarget);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04);
}

playmeleeattack(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(param_01, self.curmeleetarget);
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04);
}

choosemeleeattack(param_00, param_01, param_02) {
  self.meleeattackanimindex = randomintrange(0, self getanimentrycount(param_01));
  return self.meleeattackanimindex;
}

choosestuckanim(param_00, param_01, param_02) {
  return self.meleeattackanimindex;
}

isstuckdone(param_00, param_01, param_02, param_03) {
  return !scripts\engine\utility::istrue(self.bisstuck);
}

shoulddostuckanim(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::istrue(self.bisstuck);
}

func_3EE4(param_00, param_01, param_02) {
  return lib_0F3C::func_3EF4(param_00, param_01, param_02);
}

playmovingpainanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() < scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata().min_moving_pain_dist) {
    var_04 = func_3EE4(param_00, "pain_generic", param_03);
    self orientmode("face angle abs", self.angles);
    scripts\asm\asm_mp::func_2365(param_00, "pain_generic", param_02, var_04, 1);
    return;
  }

  scripts\asm\asm_mp::func_2364(param_01, param_02, param_03, var_04);
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

choosecrabminiturnanim(param_00, param_01, param_02) {
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

  self.desiredyaw = undefined;
  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
}