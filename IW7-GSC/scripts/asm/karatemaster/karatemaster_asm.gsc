/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\karatemaster\karatemaster_asm.gsc
*********************************************************/

setupmeleeanimdistances(var_0) {
  if(isDefined(level.karatemastermeleedist)) {
    return;
  }

  level.karatemastermeleedist = [];
  setupmeleedistances(var_0, "slow_walk_melee");
  setupmeleedistances(var_0, "walk_melee");
  setupmeleedistances(var_0, "run_melee");
  setupmeleedistances(var_0, "sprint_melee");
  setupmeleedistances(var_0, "stand_melee");
}

getfirstattacknotetracktime(var_0) {
  var_1 = 99999;
  var_2 = getnotetracktimes(var_0, "r_kick");
  if(var_2.size > 0) {
    var_1 = var_2[var_2.size - 1];
  }

  var_2 = getnotetracktimes(var_0, "l_kick");
  if(var_2.size > 0 && var_2[0] < var_1) {
    var_1 = var_2[var_2.size - 1];
  }

  var_2 = getnotetracktimes(var_0, "r_punch");
  if(var_2.size > 0 && var_2[0] < var_1) {
    var_1 = var_2[0];
  }

  var_2 = getnotetracktimes(var_0, "l_punch");
  if(var_2.size > 0 && var_2[0] < var_1) {
    var_1 = var_2[0];
  }

  if(var_1 > 999) {
    return undefined;
  }

  return var_1;
}

distcompare(var_0, var_1) {
  return var_0 < var_1;
}

setupmeleedistances(var_0, var_1) {
  var_2 = self getanimentrycount(var_1);
  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = self getsafecircleorigin(var_1, var_3);
    var_5 = getfirstattacknotetracktime(var_4);
    var_6 = getmovedelta(var_4, 0, var_5);
    var_7 = length(var_6);
    level.karatemastermeleedist[var_1][var_3] = var_7;
    var_8 = getanimlength(var_4);
    var_9 = var_5 * var_8;
    level.karatemastermeleetimetoimpact[var_1][var_3] = var_9;
  }

  level.karatemastermeleedist[var_1] = ::scripts\engine\utility::array_sort_with_func(level.karatemastermeleedist[var_1], ::distcompare);
}

karatemasterinit(var_0, var_1, var_2, var_3) {
  scripts\asm\zombie\zombie::func_13F9A(var_0, var_1, var_2, var_3);
  scripts\asm\asm_bb::bb_requestmovetype("run");
  self.disablearrivals = 1;
  setupmeleeanimdistances(var_0);
  self.desiredmovemeleeindex = [];
}

shouldplayentranceanim(var_0, var_1, var_2, var_3) {
  return 1;
}

playanimandlookatenemy(var_0, var_1, var_2, var_3) {
  thread scripts\asm\zombie\melee::func_6A6A(var_1, scripts\mp\agents\karatemaster\karatemaster_agent::getenemy());
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, 1);
}

faceenemyhelper(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self endon(var_2 + "_finished");
  }

  var_3 = gettime() + var_1;
  while(gettime() <= var_3 && isDefined(var_0) && isalive(var_0)) {
    var_4 = var_0.origin - self.origin;
    if(length2dsquared(var_4) > 1024) {
      var_5 = vectortoyaw(var_4);
      self orientmode("face angle abs", (0, var_5, 0));
    }

    wait(0.05);
  }

  self orientmode("face angle abs", self.angles);
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

playanimwithplaybackrate(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = var_3;
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5, var_4);
}

func_BEA0(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
  if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.ent)) {
    var_4 = self._blackboard.shootparams.ent.origin;
  } else if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.pos)) {
    var_4 = self._blackboard.shootparams.pos;
  } else if(isDefined(var_5)) {
    var_4 = var_5.origin;
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  var_6 = self.angles[1] - vectortoyaw(var_4 - self.origin);
  var_7 = distancesquared(self.origin, var_4);
  if(var_7 < 65536) {
    var_8 = sqrt(var_7);
    if(var_8 > 3) {
      var_6 = var_6 + asin(-3 / var_8);
    }
  }

  if(abs(angleclamp180(var_6)) > self.var_129AF) {
    return 1;
  }

  return 0;
}

func_81DE() {
  var_0 = 0.25;
  var_1 = undefined;
  var_2 = undefined;
  if(isDefined(self._blackboard.shootparams)) {
    if(isDefined(self._blackboard.shootparams.ent)) {
      var_1 = self._blackboard.shootparams.ent;
    } else if(isDefined(self._blackboard.shootparams.pos)) {
      var_2 = self._blackboard.shootparams.pos;
    }
  }

  var_3 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
  if(isDefined(var_3)) {
    if(!isDefined(var_1) && !isDefined(var_2)) {
      var_1 = var_3;
    }
  }

  if(isDefined(var_1) && !issentient(var_1)) {
    var_0 = 1.5;
  }

  var_4 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(var_0, var_1, var_2);
  return var_4;
}

func_3F0A(var_0, var_1, var_2) {
  var_3 = func_81DE();
  if(var_3 < 0) {
    var_4 = "right";
  } else {
    var_4 = "left";
  }

  var_3 = abs(var_3);
  var_5 = 0;
  if(var_3 > 157.5) {
    var_5 = 180;
  } else if(var_3 > 112.5) {
    var_5 = 135;
  } else if(var_3 > 67.5) {
    var_5 = 90;
  } else {
    var_5 = 45;
  }

  var_6 = var_4 + "_" + var_5;
  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_6);
  var_8 = self func_8101(var_1, var_7);
  return var_7;
}

func_D56A(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self.vehicle_getspawnerarray;
  self orientmode("face angle abs", self.angles);
  self ghostlaunched("anim deltas");
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4);
  if(!isDefined(var_5) && isDefined(self.vehicle_getspawnerarray)) {
    self clearpath();
  }

  scripts\asm\asm_mp::func_237F("face current");
  scripts\asm\asm_mp::func_237E("code_move");
}

func_3EE4(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}

playmovingpainanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray)) {
    var_4 = func_3EE4(var_0, "pain_generic", var_3);
    self orientmode("face angle abs", self.angles);
    scripts\asm\asm_mp::func_2365(var_0, "pain_generic", var_2, var_4, 1);
    return;
  }

  scripts\asm\asm_mp::func_2364(var_1, var_2, var_3, var_4);
}

shoulddomelee(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::istrue(self._blackboard.bmeleerequested)) {
    return 0;
  }

  if(!isDefined(self._blackboard.meleetype)) {
    return 0;
  }

  if(self._blackboard.meleetype == var_2) {
    return 1;
  }

  return 0;
}

playanim_melee(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(var_1, self._blackboard.meleetarget);
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  self func_85C9(16);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4);
}

terminate_melee(var_0, var_1, var_2) {
  self func_85C9(0);
}

choosestandmeleeanim(var_0, var_1, var_2) {
  return choosemovingmeleeanim(var_0, var_1, var_2);
}

choosemovingmeleeanim(var_0, var_1, var_2) {
  var_3 = self getanimentrycount(var_1);
  var_4 = self getsafecircleorigin(var_1, self.desiredmovemeleeindex[var_1]);
  return self.desiredmovemeleeindex[var_1];
}

choosemeleeanim(var_0, var_1, var_2) {
  if(self.asm.footsteps.foot == "left") {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "left");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "right");
}

teleportrequested(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.bteleportrequested);
}

playanim_teleportin(var_0, var_1, var_2, var_3) {
  var_4 = 1;
  if(scripts\engine\utility::istrue(self._blackboard.bfastteleport)) {
    var_4 = 3;
  }

  playanimwithplaybackrate(var_0, var_1, var_2, var_4);
}

playanim_teleportout(var_0, var_1, var_2, var_3) {
  thread scripts\asm\zombie\melee::func_6A6A(var_1, scripts\mp\agents\karatemaster\karatemaster_agent::getenemy());
  var_4 = 1;
  if(scripts\engine\utility::istrue(self._blackboard.bfastteleport)) {
    var_4 = 1.5;
  }

  playanimwithplaybackrate(var_0, var_1, var_2, var_4);
  if(scripts\engine\utility::istrue(self.btraversalteleport)) {
    self.is_traversing = undefined;
    self.btraversalteleport = undefined;
    self notify("traverse_end");
    scripts\asm\asm::asm_setstate("decide_idle", var_3);
  }
}

terminate_teleport(var_0, var_1, var_2) {
  if(!isanimdone(var_0, var_1, undefined, var_2)) {
    self show();
    self.ishidden = undefined;
  }
}

teleportnotehandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "teleport_in":
      thread doteleportin(var_1);
      break;

    case "teleport_out":
      thread doteleportout(var_1);
      break;
  }
}

playspawnin(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self setscriptablepartstate("teleport", "tele_out");
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
  wait(0.1);
  self setscriptablepartstate("teleport", "neutral");
}

doteleportin(var_0) {
  self endon(var_0 + "_finished");
  self setscriptablepartstate("teleport", "tele_in");
  wait(0.1);
  self hide();
  self.ishidden = 1;
  self setscriptablepartstate("teleport", "neutral");
}

doteleportout(var_0) {
  self endon(var_0 + "_finished");
  var_1 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
  var_2 = self._blackboard.teleportspot;
  self dontinterpolate();
  self setorigin(var_2);
  if(isDefined(var_1)) {
    self.angles = (0, vectortoyaw(var_1.origin - self.origin), 0);
  }

  wait(0.1);
  self show();
  self.ishidden = undefined;
  self setscriptablepartstate("teleport", "tele_out");
  wait(0.1);
  self setscriptablepartstate("teleport", "neutral");
}

meleenotehandler(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = undefined;
  var_6 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
  if(var_0 == "r_kick") {
    var_4 = var_6.ckickmeleedamage;
    var_5 = self gettagorigin("j_ankle_ri");
    self scragentsetanimscale(1, 1);
  } else if(var_0 == "l_kick") {
    var_4 = var_6.ckickmeleedamage;
    var_5 = self gettagorigin("j_ankle_le");
    self scragentsetanimscale(1, 1);
  } else if(var_0 == "r_punch") {
    var_4 = var_6.cpunchmeleedamage;
    var_5 = self gettagorigin("j_wrist_ri");
    self scragentsetanimscale(1, 1);
  } else if(var_0 == "l_punch") {
    var_4 = var_6.cpunchmeleedamage;
    var_5 = self gettagorigin("j_wrist_le");
    self scragentsetanimscale(1, 1);
  } else if(var_0 == "flex_start") {
    var_7 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
    if(isDefined(var_7)) {
      var_8 = self getsafecircleorigin(var_1, var_2);
      var_9 = getfirstattacknotetracktime(var_8);
      if(var_9 > var_3) {
        var_10 = getmovedelta(var_8, var_3, var_9);
        var_11 = length2d(var_10);
        var_12 = getanimlength(var_8);
        var_13 = var_9 * var_12 - var_3 * var_12;
        var_14 = var_7 getvelocity();
        var_15 = var_7.origin + var_14 * var_13;
        var_10 = distance(var_15, self.origin);
        var_11 = 1;
        if(var_10 > var_11 && var_11 > 0) {
          var_11 = var_10 / var_11;
          if(var_11 > var_6.cmaxmeleeflexscale) {
            var_11 = var_6.cmaxmeleeflexscale;
          }
        }

        self scragentsetanimscale(var_11, 1);
      }
    }
  }

  if(isDefined(var_4)) {
    var_7 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
    if(isDefined(var_7)) {
      var_12 = distance2dsquared(var_7.origin, self.origin);
      var_13 = distance2dsquared(var_5, var_7.origin);
      if(var_13 < var_6.cpunchandkickmeleeradiussq || var_12 < var_6.cpunchandkickmeleeradiussq) {
        self notify("attack_hit", var_7);
        scripts\asm\zombie\melee::domeleedamage(var_7, var_4, "MOD_IMPACT");
        return;
      }

      self notify("attack_miss", var_7);
      return;
    }
  }
}

ontraversalteleport(var_0, var_1, var_2, var_3) {
  self._blackboard.teleportspot = self func_8146();
  self.btraversalteleport = 1;
  return 1;
}