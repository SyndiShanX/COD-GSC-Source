/**********************************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_sasquatch\behaviors.gsc
**********************************************************/

sasquatch_init(var_0) {
  var_1 = gettime();
  self.bt.allowthrowtime = var_1 + 8000;
  self.bt.allowrushtime = var_1 + 5000;
  return anim.success;
}

isintrees(var_0) {
  return anim.failure;
}

updateeveryframe(var_0) {
  if(!isalive(self)) {
    return anim.failure;
  }

  if(isDefined(self.scripted) && self.scripted) {
    return anim.failure;
  }

  var_1 = getclosestplayer();
  self.bt.enemy = var_1;
  return anim.success;
}

shouldswingaround(var_0) {
  return anim.failure;
}

shouldthrowrock(var_0) {
  if(!isDefined(self.bt.enemy)) {
    return anim.failure;
  }

  if(gettime() < self.bt.allowthrowtime) {
    return anim.failure;
  }

  var_1 = distance2dsquared(self.bt.enemy.origin, self.origin);

  if(var_1 > 360000) {
    return anim.failure;
  }

  if(var_1 < 16384) {
    return anim.failure;
  }

  if(!self cansee(self.bt.enemy)) {
    return anim.failure;
  }

  return anim.success;
}

throwattack_check(var_0) {
  var_1 = scripts\asm\asm_bb::bb_getthrowgrenadetarget();

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  if(!isalive(var_1)) {
    return anim.failure;
  }

  if(distancesquared(self.origin, var_1.origin) > 518400) {
    return anim.failure;
  }

  return anim.success;
}

throwattack_init(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].starttime = gettime();
  self.bt.instancedata[var_0].target = self.bt.enemy;
  self scragentsetgoalpos(self.origin);
  self scragentsetgoalradius(64);
  scripts\asm\asm_bb::bb_requestthrowgrenade(1, self.bt.enemy);
}

throwattack(var_0) {
  var_1 = 5000;

  if(gettime() - self.bt.instancedata[var_0].starttime > var_1) {
    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwevent", "end")) {
    return anim.success;
  }

  return anim.running;
}

throwattack_cleanup(var_0) {
  self.bt.instancedata[var_0] = undefined;
  scripts\asm\asm_bb::bb_requestthrowgrenade(0);
  self.bt.allowthrowtime = gettime() + 8000;
}

shouldmelee(var_0) {
  if(!isDefined(self.bt.enemy)) {
    return anim.failure;
  }

  var_1 = self.bt.enemy;

  if(isDefined(self.bt.lastmeleefailtarget) && self.bt.lastmeleefailtarget == var_1 && gettime() - self.bt.lastmeleefailtime < 3000) {
    return anim.failure;
  }

  var_2 = var_1.origin - self.origin;
  var_3 = length2dsquared(var_2);

  if(var_3 > 65536) {
    return anim.failure;
  }

  if(abs(var_2[2]) > 72 && var_3 < 10000) {
    return anim.failure;
  }

  return anim.success;
}

melee_setup(var_0) {
  self.bt.meleetarget = self.bt.enemy;
  return anim.success;
}

melee_shouldabort() {
  var_0 = self.bt.meleetarget;

  if(!isDefined(var_0)) {
    return 1;
  }

  if(!isalive(var_0)) {
    return 1;
  }

  return 0;
}

melee_cleanup() {
  self.bt.meleetarget = undefined;
}

melee_failed(var_0, var_1) {
  self.bt.lastmeleefailtime = gettime();
  self.bt.lastmeleefailtarget = var_1;
  self.bt.lastmeleefailreason = var_0;
}

melee_charge_init(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].starttime = gettime();
  self.bt.instancedata[var_0].prevgoalpos = self.origin;
}

melee_charge(var_0) {
  if(melee_shouldabort()) {
    return anim.failure;
  }

  var_1 = self.bt.meleetarget;
  var_2 = gettime() - self.bt.instancedata[var_0].starttime;
  var_3 = isDefined(self getpathgoalpos());

  if(var_2 > 200 && !var_3) {
    melee_failed(1, var_1);
    return anim.failure;
  }

  if(var_2 > 5000) {
    melee_failed(3, var_1);
    return anim.failure;
  }

  var_4 = var_1.origin - self.origin;
  var_5 = length2dsquared(var_4);
  var_6 = var_5;

  if(var_3) {
    var_7 = self pathdisttogoal();
    var_6 = var_7 * var_7;
  }

  if(var_6 > 200704) {
    melee_failed(2, var_1);
    return anim.failure;
  }

  if(var_5 < 5184) {
    var_8 = self func_84AC();
    var_9 = getclosestpointonnavmesh(var_1.origin, self);

    if(func_2AC(var_8, var_9, self)) {
      self.bt.instancedata[var_0].bsuccess = 1;
      return anim.success;
    }
  }

  var_10 = var_1.origin;
  var_11 = 144;

  if(distance2dsquared(var_10, self.bt.instancedata[var_0].prevgoalpos) > var_11) {
    self scragentsetgoalpos(var_10);
    self scragentsetgoalradius(24);
    self.bt.instancedata[var_0].prevgoalpos = var_10;
  }

  return anim.running;
}

melee_charge_cleanup(var_0) {
  if(!isDefined(self.bt.instancedata[var_0].bsuccess)) {
    melee_cleanup();
  }

  self.bt.instancedata[var_0] = undefined;
}

melee_attack_init(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].starttime = gettime();
  scripts\asm\asm_bb::bb_requestmelee(self.bt.meleetarget);
  self scragentsetgoalpos(self.origin);
  self scragentsetgoalradius(64);
}

melee_attack(var_0) {
  if(melee_shouldabort()) {
    return anim.failure;
  }

  var_1 = 10000;

  if(gettime() - self.bt.instancedata[var_0].starttime > var_1) {
    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("meleeattack", "end")) {
    return anim.success;
  }

  return anim.running;
}

melee_attack_cleanup(var_0) {
  self.bt.instancedata[var_0] = undefined;
  melee_cleanup();
  scripts\asm\asm_bb::bb_clearmeleerequest();
}

shouldrush(var_0) {
  var_1 = self.bt.enemy;

  if(!isDefined(var_1) || !isalive(var_1)) {
    return anim.failure;
  }

  if(gettime() < self.bt.allowrushtime) {
    return anim.failure;
  }

  var_2 = var_1.origin - self.origin;
  var_3 = length2dsquared(var_2);

  if(var_3 > 589824) {
    return anim.failure;
  }

  if(var_3 < 32400) {
    return anim.failure;
  }

  if(isDefined(self.pathgoalpos)) {
    var_4 = self func_84F9(84);

    if(isDefined(var_4)) {
      return anim.failure;
    }

    if(self pathdisttogoal() > 1179648) {
      return anim.failure;
    }
  }

  if(!self cansee(var_1)) {
    return anim.failure;
  }

  return anim.success;
}

rush_charge_init(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].starttime = gettime();
  self.bt.instancedata[var_0].startpos = self.origin;
  self.bt.instancedata[var_0].btracking = 1;
  self._blackboard.movetype = "sprint";
  self._blackboard.brushorienttoenemy = 1;
  self._blackboard.brushrequested = 1;
  self.bt.meleetarget = self.bt.enemy;
}

rush_charge(var_0) {
  var_1 = 0;
  var_2 = 1;
  var_3 = 2;

  if(melee_shouldabort()) {
    return anim.success;
  }

  var_4 = gettime();
  var_5 = self.bt.instancedata[var_0].starttime;
  var_6 = 8000;

  if(var_4 > var_5 + var_6) {
    self.bt.instancedata[var_0].bfailure = 1;
    return anim.failure;
  }

  if(distance2dsquared(self.origin, self.bt.instancedata[var_0].startpos) > 262144) {
    return anim.success;
  }

  var_7 = self.bt.meleetarget.origin - self.origin;

  if(length2dsquared(var_7) < 20736) {
    self.bt.instancedata[var_0].bsuccess = 1;
    return anim.success;
  }

  if(var_4 > var_5 + 200 && !isDefined(self.pathgoalpos)) {
    self.bt.instancedata[var_0].bfailure = 1;
    return anim.failure;
  }

  var_8 = self func_84F9(84);

  if(isDefined(var_8)) {
    self.bt.instancedata[var_0].bfailure = 1;
    return anim.failure;
  }

  if(self.bt.instancedata[var_0].btracking) {
    var_9 = 1000;

    if(var_4 > self.bt.instancedata[var_0].starttime + var_9) {
      var_10 = vectornormalize((var_7[0], var_7[1], 0));
      var_11 = self getlookaheaddir();
      var_11 = vectornormalize((var_11[0], var_11[1], 0));

      if(vectordot(var_7, var_11) < 0.966) {
        var_12 = self.origin + var_11 * 208;
        var_13 = self func_84AC();
        var_14 = navtrace(var_13, var_12, self, 1);

        if(var_14["fraction"] < 1) {
          var_12 = var_14["position"];
        }

        self scragentsetgoalpos(var_12);
        self scragentsetgoalradius(24);
        self.bt.instancedata[var_0].btracking = 0;
      } else {
        self scragentsetgoalpos(self.bt.meleetarget.origin);
        self scragentsetgoalradius(24);
      }
    } else {
      self scragentsetgoalpos(self.bt.meleetarget.origin);
      self scragentsetgoalradius(24);
    }
  } else if(self pathdisttogoal() < 144) {
    return anim.success;
  }

  return anim.running;
}

rush_charge_cleanup(var_0) {
  if(!isDefined(self.bt.instancedata[var_0].bsuccess)) {
    melee_cleanup();
    self.bt.allowrushtime = gettime() + 1000;
  }

  self._blackboard.movetype = "run";
  self._blackboard.brushrequested = undefined;
  self.bt.instancedata[var_0] = undefined;
}

rush_attack_init(var_0) {
  self.bt.instancedata[var_0] = gettime();
  scripts\asm\asm_bb::bb_requestmelee(self.bt.meleetarget);
}

rush_attack(var_0) {
  var_1 = gettime();
  var_2 = 5000;

  if(var_1 > self.bt.instancedata[var_0] + var_2) {
    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("rushattack", "end")) {
    self.bt.allowrushtime = var_1 + 5000;
    return anim.success;
  }

  self scragentsetgoalpos(self.origin);
  self scragentsetgoalradius(36);
  return anim.running;
}

rush_attack_cleanup(var_0) {
  self.bt.instancedata[var_0] = undefined;
  scripts\asm\asm_bb::bb_clearmeleerequest();
  melee_cleanup();
}

shouldtaunt(var_0) {
  if(isDefined(self.killed_player)) {
    self.killed_player = undefined;
    return anim.success;
  }

  return anim.failure;
}

taunt_init(var_0) {
  self.bt.instancedata[var_0] = gettime();
  self._blackboard.btauntrequested = 1;
  self scragentsetgoalpos(self.origin);
  self scragentsetgoalradius(64);
}

dotaunt(var_0) {
  var_1 = 6000;

  if(gettime() - self.bt.instancedata[var_0] > var_1) {
    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("tauntevent", "end")) {
    return anim.success;
  }

  return anim.running;
}

taunt_cleanup(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self._blackboard.btauntrequested = undefined;
}

wander_init(var_0) {
  var_1 = spawnStruct();
  var_1.curtargetpos = self.origin;
  var_1.nextchecktime = gettime();
  self.bt.instancedata[var_0] = var_1;
}

getclosestplayer() {
  var_0 = undefined;
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(!isalive(var_3)) {
      continue;
    }
    if(var_3.ignoreme || isDefined(var_3.owner) && var_3.owner.ignoreme) {
      continue;
    }
    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_3)) {
      continue;
    }
    var_4 = distance2dsquared(self.origin, var_3.origin);

    if(!isDefined(var_0) || var_4 < var_1) {
      var_0 = var_3;
      var_1 = var_4;
    }
  }

  return var_0;
}

wander(var_0) {
  if(isDefined(self.bt.enemy) && !scripts\engine\utility::is_true(self.bt.enemy.ignoreme)) {
    var_1 = self.bt.enemy.origin;

    if(!isDefined(self.pathgoalpos) || distance2dsquared(var_1, self.bt.instancedata[var_0].curtargetpos) > 1296) {
      self.bt.instancedata[var_0].curtargetpos = var_1;
      var_2 = getclosestpointonnavmesh(var_1, self);
      self scragentsetgoalpos(var_2);
    }
  } else if(gettime() >= self.bt.instancedata[var_0].nextchecktime || isDefined(self.bt.enemy) && scripts\engine\utility::is_true(self.bt.enemy.ignoreme)) {
    var_3 = getclosestplayer();

    if(isDefined(var_3)) {
      self.bt.instancedata[var_0].curtargetpos = var_3.origin;
      var_2 = getclosestpointonnavmesh(var_3.origin, self);
      self scragentsetgoalpos(var_2);
      self.bt.instancedata[var_0].nextchecktime = self.bt.instancedata[var_0].nextchecktime + 2000;
    }
  }

  return anim.running;
}

wander_cleanup(var_0) {
  self.bt.instancedata[var_0] = undefined;
}