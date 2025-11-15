/*********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\karatemaster\karatemaster_asm.gsc
*********************************************************/

setupmeleeanimdistances(param_00) {
  if(isDefined(level.karatemastermeleedist)) {
    return;
  }

  level.karatemastermeleedist = [];
  setupmeleedistances(param_00, "slow_walk_melee");
  setupmeleedistances(param_00, "walk_melee");
  setupmeleedistances(param_00, "run_melee");
  setupmeleedistances(param_00, "sprint_melee");
  setupmeleedistances(param_00, "stand_melee");
}

getfirstattacknotetracktime(param_00) {
  var_01 = 99999;
  var_02 = getnotetracktimes(param_00, "r_kick");
  if(var_02.size > 0) {
    var_01 = var_02[var_02.size - 1];
  }

  var_02 = getnotetracktimes(param_00, "l_kick");
  if(var_02.size > 0 && var_02[0] < var_01) {
    var_01 = var_02[var_02.size - 1];
  }

  var_02 = getnotetracktimes(param_00, "r_punch");
  if(var_02.size > 0 && var_02[0] < var_01) {
    var_01 = var_02[0];
  }

  var_02 = getnotetracktimes(param_00, "l_punch");
  if(var_02.size > 0 && var_02[0] < var_01) {
    var_01 = var_02[0];
  }

  if(var_01 > 999) {
    return undefined;
  }

  return var_01;
}

distcompare(param_00, param_01) {
  return param_00 < param_01;
}

setupmeleedistances(param_00, param_01) {
  var_02 = self getanimentrycount(param_01);
  for(var_03 = 0; var_03 < var_02; var_03++) {
    var_04 = self getsafecircleorigin(param_01, var_03);
    var_05 = getfirstattacknotetracktime(var_04);
    var_06 = getmovedelta(var_04, 0, var_05);
    var_07 = length(var_06);
    level.karatemastermeleedist[param_01][var_03] = var_07;
    var_08 = getanimlength(var_04);
    var_09 = var_05 * var_08;
    level.karatemastermeleetimetoimpact[param_01][var_03] = var_09;
  }

  level.karatemastermeleedist[param_01] = scripts\engine\utility::array_sort_with_func(level.karatemastermeleedist[param_01], ::distcompare);
}

karatemasterinit(param_00, param_01, param_02, param_03) {
  scripts\asm\zombie\zombie::func_13F9A(param_00, param_01, param_02, param_03);
  scripts\asm\asm_bb::bb_requestmovetype("run");
  self.disablearrivals = 1;
  setupmeleeanimdistances(param_00);
  self.desiredmovemeleeindex = [];
}

shouldplayentranceanim(param_00, param_01, param_02, param_03) {
  return 1;
}

playanimandlookatenemy(param_00, param_01, param_02, param_03) {
  thread scripts\asm\zombie\melee::func_6A6A(param_01, scripts\mp\agents\karatemaster\karatemaster_agent::getenemy());
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, 1);
}

faceenemyhelper(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    self endon(param_02 + "_finished");
  }

  var_03 = gettime() + param_01;
  while(gettime() <= var_03 && isDefined(param_00) && isalive(param_00)) {
    var_04 = param_00.origin - self.origin;
    if(length2dsquared(var_04) > 1024) {
      var_05 = vectortoyaw(var_04);
      self orientmode("face angle abs", (0, var_05, 0));
    }

    wait(0.05);
  }

  self orientmode("face angle abs", self.angles);
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

playanimwithplaybackrate(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = param_03;
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_05, var_04);
}

func_BEA0(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  var_05 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
  if(isDefined(self.var_1198.shootparams) && isDefined(self.var_1198.shootparams.ent)) {
    var_04 = self.var_1198.shootparams.ent.origin;
  } else if(isDefined(self.var_1198.shootparams) && isDefined(self.var_1198.shootparams.pos)) {
    var_04 = self.var_1198.shootparams.pos;
  } else if(isDefined(var_05)) {
    var_04 = var_05.origin;
  }

  if(!isDefined(var_04)) {
    return 0;
  }

  var_06 = self.angles[1] - vectortoyaw(var_04 - self.origin);
  var_07 = distancesquared(self.origin, var_04);
  if(var_07 < 65536) {
    var_08 = sqrt(var_07);
    if(var_08 > 3) {
      var_06 = var_06 + asin(-3 / var_08);
    }
  }

  if(abs(angleclamp180(var_06)) > self.var_129AF) {
    return 1;
  }

  return 0;
}

_meth_81DE() {
  var_00 = 0.25;
  var_01 = undefined;
  var_02 = undefined;
  if(isDefined(self.var_1198.shootparams)) {
    if(isDefined(self.var_1198.shootparams.ent)) {
      var_01 = self.var_1198.shootparams.ent;
    } else if(isDefined(self.var_1198.shootparams.pos)) {
      var_02 = self.var_1198.shootparams.pos;
    }
  }

  var_03 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
  if(isDefined(var_03)) {
    if(!isDefined(var_01) && !isDefined(var_02)) {
      var_01 = var_03;
    }
  }

  if(isDefined(var_01) && !issentient(var_01)) {
    var_00 = 1.5;
  }

  var_04 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(var_00, var_01, var_02);
  return var_04;
}

func_3F0A(param_00, param_01, param_02) {
  var_03 = _meth_81DE();
  if(var_03 < 0) {
    var_04 = "right";
  } else {
    var_04 = "left";
  }

  var_03 = abs(var_03);
  var_05 = 0;
  if(var_03 > 157.5) {
    var_05 = 180;
  } else if(var_03 > 112.5) {
    var_05 = 135;
  } else if(var_03 > 67.5) {
    var_05 = 90;
  } else {
    var_05 = 45;
  }

  var_06 = var_04 + "_" + var_05;
  var_07 = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_06);
  var_08 = self _meth_8101(param_01, var_07);
  return var_07;
}

func_D56A(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = self.vehicle_getspawnerarray;
  self orientmode("face angle abs", self.angles);
  self ghostlaunched("anim deltas");
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04);
  if(!isDefined(var_05) && isDefined(self.vehicle_getspawnerarray)) {
    self clearpath();
  }

  scripts\asm\asm_mp::func_237F("face current");
  scripts\asm\asm_mp::func_237E("code_move");
}

func_3EE4(param_00, param_01, param_02) {
  return lib_0F3C::func_3EF4(param_00, param_01, param_02);
}

playmovingpainanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray)) {
    var_04 = func_3EE4(param_00, "pain_generic", param_03);
    self orientmode("face angle abs", self.angles);
    scripts\asm\asm_mp::func_2365(param_00, "pain_generic", param_02, var_04, 1);
    return;
  }

  scripts\asm\asm_mp::func_2364(param_01, param_02, param_03, var_04);
}

shoulddomelee(param_00, param_01, param_02, param_03) {
  if(!scripts\engine\utility::istrue(self.var_1198.bmeleerequested)) {
    return 0;
  }

  if(!isDefined(self.var_1198.meleetype)) {
    return 0;
  }

  if(self.var_1198.meleetype == param_02) {
    return 1;
  }

  return 0;
}

playanim_melee(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(param_01, self.var_1198.meleetarget);
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  self _meth_85C9(16);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04);
}

terminate_melee(param_00, param_01, param_02) {
  self _meth_85C9(0);
}

choosestandmeleeanim(param_00, param_01, param_02) {
  return choosemovingmeleeanim(param_00, param_01, param_02);
}

choosemovingmeleeanim(param_00, param_01, param_02) {
  var_03 = self getanimentrycount(param_01);
  var_04 = self getsafecircleorigin(param_01, self.desiredmovemeleeindex[param_01]);
  return self.desiredmovemeleeindex[param_01];
}

choosemeleeanim(param_00, param_01, param_02) {
  if(self.asm.footsteps.foot == "left") {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "left");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "right");
}

teleportrequested(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.bteleportrequested);
}

playanim_teleportin(param_00, param_01, param_02, param_03) {
  var_04 = 1;
  if(scripts\engine\utility::istrue(self.var_1198.bfastteleport)) {
    var_04 = 3;
  }

  playanimwithplaybackrate(param_00, param_01, param_02, var_04);
}

playanim_teleportout(param_00, param_01, param_02, param_03) {
  thread scripts\asm\zombie\melee::func_6A6A(param_01, scripts\mp\agents\karatemaster\karatemaster_agent::getenemy());
  var_04 = 1;
  if(scripts\engine\utility::istrue(self.var_1198.bfastteleport)) {
    var_04 = 1.5;
  }

  playanimwithplaybackrate(param_00, param_01, param_02, var_04);
  if(scripts\engine\utility::istrue(self.btraversalteleport)) {
    self.is_traversing = undefined;
    self.btraversalteleport = undefined;
    self notify("traverse_end");
    scripts\asm\asm::asm_setstate("decide_idle", param_03);
  }
}

terminate_teleport(param_00, param_01, param_02) {
  if(!isanimdone(param_00, param_01, undefined, param_02)) {
    self show();
    self.ishidden = undefined;
  }
}

teleportnotehandler(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "teleport_in":
      thread doteleportin(param_01);
      break;

    case "teleport_out":
      thread doteleportout(param_01);
      break;
  }
}

playspawnin(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self setscriptablepartstate("teleport", "tele_out");
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
  wait(0.1);
  self setscriptablepartstate("teleport", "neutral");
}

doteleportin(param_00) {
  self endon(param_00 + "_finished");
  self setscriptablepartstate("teleport", "tele_in");
  wait(0.1);
  self hide();
  self.ishidden = 1;
  self setscriptablepartstate("teleport", "neutral");
}

doteleportout(param_00) {
  self endon(param_00 + "_finished");
  var_01 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
  var_02 = self.var_1198.teleportspot;
  self dontinterpolate();
  self setorigin(var_02);
  if(isDefined(var_01)) {
    self.angles = (0, vectortoyaw(var_01.origin - self.origin), 0);
  }

  wait(0.1);
  self show();
  self.ishidden = undefined;
  self setscriptablepartstate("teleport", "tele_out");
  wait(0.1);
  self setscriptablepartstate("teleport", "neutral");
}

meleenotehandler(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  var_05 = undefined;
  var_06 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
  if(param_00 == "r_kick") {
    var_04 = var_06.ckickmeleedamage;
    var_05 = self gettagorigin("j_ankle_ri");
    self scragentsetanimscale(1, 1);
  } else if(param_00 == "l_kick") {
    var_04 = var_06.ckickmeleedamage;
    var_05 = self gettagorigin("j_ankle_le");
    self scragentsetanimscale(1, 1);
  } else if(param_00 == "r_punch") {
    var_04 = var_06.cpunchmeleedamage;
    var_05 = self gettagorigin("j_wrist_ri");
    self scragentsetanimscale(1, 1);
  } else if(param_00 == "l_punch") {
    var_04 = var_06.cpunchmeleedamage;
    var_05 = self gettagorigin("j_wrist_le");
    self scragentsetanimscale(1, 1);
  } else if(param_00 == "flex_start") {
    var_07 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
    if(isDefined(var_07)) {
      var_08 = self getsafecircleorigin(param_01, param_02);
      var_09 = getfirstattacknotetracktime(var_08);
      if(var_09 > param_03) {
        var_0A = getmovedelta(var_08, param_03, var_09);
        var_0B = length2d(var_0A);
        var_0C = getanimlength(var_08);
        var_0D = var_09 * var_0C - param_03 * var_0C;
        var_0E = var_07 getvelocity();
        var_0F = var_07.origin + var_0E * var_0D;
        var_10 = distance(var_0F, self.origin);
        var_11 = 1;
        if(var_10 > var_0B && var_0B > 0) {
          var_11 = var_10 / var_0B;
          if(var_11 > var_06.cmaxmeleeflexscale) {
            var_11 = var_06.cmaxmeleeflexscale;
          }
        }

        self scragentsetanimscale(var_11, 1);
      }
    }
  }

  if(isDefined(var_04)) {
    var_07 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
    if(isDefined(var_07)) {
      var_12 = distance2dsquared(var_07.origin, self.origin);
      var_13 = distance2dsquared(var_05, var_07.origin);
      if(var_13 < var_06.cpunchandkickmeleeradiussq || var_12 < var_06.cpunchandkickmeleeradiussq) {
        self notify("attack_hit", var_07);
        scripts\asm\zombie\melee::domeleedamage(var_07, var_04, "MOD_IMPACT");
        return;
      }

      self notify("attack_miss", var_07);
      return;
    }
  }
}

ontraversalteleport(param_00, param_01, param_02, param_03) {
  self.var_1198.teleportspot = self _meth_8146();
  self.btraversalteleport = 1;
  return 1;
}