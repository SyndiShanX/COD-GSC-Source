/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\crab_mini\crab_mini_asm.gsc
***************************************************/

asminit(var_0, var_1, var_2, var_3) {
  scripts\asm\zombie\zombie::func_13F9A(var_0, var_1, var_2, var_3);
  analyzeanims();
}

analyzeanims() {
  var_0 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
  if(!isDefined(var_0.min_moving_pain_dist)) {
    var_1 = self getsafecircleorigin("pain_moving", 0);
    var_2 = getmovedelta(var_1, 0, 1);
    var_0.min_moving_pain_dist = length(var_2);
  }
}

isvalidaction(var_0) {
  switch (var_0) {
    case "moving_melee":
    case "stand_melee":
      return 1;
  }

  return 0;
}

setaction(var_0) {
  self.requested_action = var_0;
}

clearaction() {
  self.requested_action = undefined;
}

shouldplayentranceanim(var_0, var_1, var_2, var_3) {
  return 1;
}

playanimandlookatenemy(var_0, var_1, var_2, var_3) {
  thread scripts\asm\zombie\melee::func_6A6A(var_1, scripts\mp\agents\crab_mini\crab_mini_agent::getenemy());
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, 1);
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
  var_3 = anglesToForward(self.angles);
  var_4 = vectordot(var_2, var_3);
  if(var_4 > var_1) {
    return 1;
  }

  return 0;
}

shouldmeleeattackhit(var_0, var_1, var_2) {
  if(scripts\mp\agents\zombie\zombie_util::func_9DE0(var_0)) {
    return 1;
  }

  var_3 = distance2dsquared(var_0.origin, self.origin);
  if(var_3 > var_1) {
    return 0;
  }

  if(!ismyenemyinfrontofme(var_0, var_2)) {
    return 0;
  }

  return 1;
}

playmovingmelee(var_0, var_1, var_2, var_3) {
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

domeleedamageoncontact(var_0, var_1) {
  self endon(var_0 + "_finished");
  self endon("DoMeleeDamageOnContact_stop");
  var_2 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
  while(isDefined(var_1) && isalive(var_1)) {
    if(shouldmeleeattackhit(var_1, var_2.moving_melee_attack_damage_radius_sq, var_2.melee_dot)) {
      if(randomint(100) < var_2.chance_to_get_stuck_if_hit) {
        scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(1);
      } else {
        scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(0);
      }

      scripts\asm\zombie\melee::func_1106E();
      scripts\asm\zombie\melee::domeleedamage(var_1, self.var_B601, "MOD_IMPACT");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

movingmeleenotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    self scragentsetanimscale(1, 1);
    self notify("DoMeleeDamageOnContact_stop");
    return;
  }

  if(var_0 == "flex_start") {
    var_4 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
    if(isDefined(var_4)) {
      var_5 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
      var_6 = self getsafecircleorigin(var_1, var_2);
      var_7 = getnotetracktimes(var_6, "hit");
      var_8 = var_7[0];
      if(var_8 > var_3) {
        var_9 = getmovedelta(var_6, var_3, var_8);
        var_0A = length2d(var_9);
        var_0B = getanimlength(var_6);
        var_0C = var_8 * var_0B - var_3 * var_0B;
        var_0D = var_4 getvelocity();
        var_0E = var_4.origin + var_0D * var_0C;
        var_0F = distance(var_0E, self.origin);
        var_10 = 1;
        if(var_0F > var_0A && var_0A > 0) {
          var_10 = var_0F / var_0A;
          if(var_10 < 1) {
            var_10 = 1;
          }

          var_10 = var_10 + var_5.melee_xy_scale_boost;
          if(var_10 > var_5.melee_max_flex_xy_scale) {
            var_10 = var_5.melee_max_flex_xy_scale;
          }
        } else {
          var_10 = 1 + var_5.melee_xy_scale_boost;
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

meleenotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    self scragentsetanimscale(1, 1);
    var_4 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
    if(isDefined(var_4)) {
      var_5 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
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

timetogetstuck(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.btimetogetstuck)) {
    self.btimetogetstuck = undefined;
    return 1;
  }

  return 0;
}

terminate_movingmelee(var_0, var_1, var_2) {
  self.btimetogetstuck = undefined;
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

shoulddoaction(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.requested_action)) {
    return 0;
  }

  if(self.requested_action == var_2) {
    return 1;
  }

  return 0;
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

playmovingmeleeattack(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self getsafecircleorigin(var_1, var_4);
  var_6 = getanimlength(var_5);
  var_7 = getnotetracktimes(var_5, "hit");
  var_8 = var_6 * var_7[0];
  var_9 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
  var_0A = randomfloatrange(var_9.min_stop_facing_enemy_time_before_hit, var_9.max_stop_facing_enemy_time_before_hit);
  var_0B = var_8 - var_0A;
  if(var_0B < 0) {
    var_0B = 0.1;
  }

  if(randomint(100) < var_9.chance_to_get_stuck_if_miss) {
    scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(1);
  } else {
    scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(0);
  }

  thread scripts\asm\zombie\melee::func_6A6A(var_1, self.curmeleetarget);
  thread stopfacingenemy(var_1, var_0B);
  thread domeleedamageoncontact(var_1, self.curmeleetarget);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4);
}

playmeleeattack(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(var_1, self.curmeleetarget);
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4);
}

choosemeleeattack(var_0, var_1, var_2) {
  self.meleeattackanimindex = randomintrange(0, self getanimentrycount(var_1));
  return self.meleeattackanimindex;
}

choosestuckanim(var_0, var_1, var_2) {
  return self.meleeattackanimindex;
}

isstuckdone(var_0, var_1, var_2, var_3) {
  return !scripts\engine\utility::istrue(self.bisstuck);
}

shoulddostuckanim(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.bisstuck);
}

func_3EE4(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}

playmovingpainanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() < scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata().min_moving_pain_dist) {
    var_4 = func_3EE4(var_0, "pain_generic", var_3);
    self orientmode("face angle abs", self.angles);
    scripts\asm\asm_mp::func_2365(var_0, "pain_generic", var_2, var_4, 1);
    return;
  }

  scripts\asm\asm_mp::func_2364(var_1, var_2, var_3, var_4);
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

choosecrabminiturnanim(var_0, var_1, var_2) {
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

  self.desiredyaw = undefined;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}