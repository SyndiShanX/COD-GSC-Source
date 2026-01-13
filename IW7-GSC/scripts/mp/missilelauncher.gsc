/******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\missilelauncher.gsc
******************************************/

func_98D5() {
  self.var_10FA9 = undefined;
  self.var_10FAA = undefined;
  self.var_10FA6 = undefined;
  self.var_10FA7 = undefined;
  thread func_E273();
  level.var_10FAB = [];
}

resetmissilelauncherlocking() {
  if(!isDefined(self.var_10FAE)) {
    return;
  }

  self.var_10FAE = undefined;
  self notify("stop_javelin_locking_feedback");
  self notify("stop_javelin_locked_feedback");
  self notify("stinger_lock_lost");
  self weaponlockfree();
  self stoplocalsound("maaws_reticle_tracking");
  self stoplocalsound("maaws_reticle_locked");
  func_E12E(self.var_10FAA);
  func_98D5();
}

func_E273() {
  self endon("disconnect");
  self notify("ResetStingerLockingOnDeath");
  self endon("ResetStingerLockingOnDeath");
  for(;;) {
    self waittill("death");
    resetmissilelauncherlocking();
  }
}

func_B06A() {
  self endon("stop_javelin_locking_feedback");
  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.var_10FAA) && self.var_10FAA == level.chopper.gunner) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    if(isDefined(level.ac130player) && isDefined(self.var_10FAA) && self.var_10FAA == level.ac130.planemodel) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    self playlocalsound("maaws_reticle_tracking");
    self playrumbleonentity("ac130_25mm_fire");
    wait(0.6);
  }
}

func_B069() {
  self endon("stop_javelin_locked_feedback");
  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.var_10FAA) && self.var_10FAA == level.chopper.gunner) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    if(isDefined(level.ac130player) && isDefined(self.var_10FAA) && self.var_10FAA == level.ac130.planemodel) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    self playlocalsound("maaws_reticle_locked");
    self playrumbleonentity("ac130_25mm_fire");
    wait(0.25);
  }
}

softsighttest(var_0) {
  var_1 = 500;
  if(var_0 stingtargstruct_isinlos()) {
    self.var_10FA7 = 0;
    return 1;
  }

  if(self.var_10FA7 == 0) {
    self.var_10FA7 = gettime();
  }

  var_2 = gettime() - self.var_10FA7;
  if(var_2 >= var_1) {
    resetmissilelauncherlocking();
    return 0;
  }

  return 1;
}

func_10FAD() {
  if(!isplayer(self)) {
    return;
  }

  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  func_98D5();
  for(;;) {
    wait(0.05);
    if(self getweaponrankinfominxp() < 0.95) {
      resetmissilelauncherlocking();
      continue;
    }

    var_0 = scripts\mp\utility::getweaponbasedsmokegrenadecount(self getcurrentweapon());
    if(var_0 != "iw7_lockon_mp") {
      resetmissilelauncherlocking();
      continue;
    }

    self.var_10FAE = 1;
    if(!isDefined(self.var_10FA9)) {
      self.var_10FA9 = 0;
    }

    if(self.var_10FA9 == 0) {
      var_1 = scripts\mp\weapons::func_AF2B(0);
      if(var_1.size == 0) {
        continue;
      }

      var_1 = sortbydistance(var_1, self.origin);
      var_2 = undefined;
      var_3 = 0;
      foreach(var_5 in var_1) {
        if(!isDefined(var_5)) {
          continue;
        }

        var_2 = stingtargstruct_create(self, var_5);
        var_2 stingtargstruct_getoffsets();
        var_2 stingtargstruct_getorigins();
        var_2 stingtargstruct_getinreticle();
        if(var_2 stingtargstruct_isinreticle()) {
          var_3 = 1;
          break;
        }
      }

      if(!var_3) {
        continue;
      }

      var_2 stingtargstruct_getinlos();
      if(!var_2 stingtargstruct_isinlos()) {
        continue;
      }

      self.var_10FAA = var_2.target;
      self.var_10FA6 = gettime();
      self.var_10FA9 = 1;
      self.var_10FA7 = 0;
      func_17D0(self.var_10FAA);
      thread func_B06A();
    }

    if(self.var_10FA9 == 1) {
      if(!isDefined(self.var_10FAA)) {
        resetmissilelauncherlocking();
        continue;
      }

      var_2 = stingtargstruct_create(self, self.var_10FAA);
      var_2 stingtargstruct_getoffsets();
      var_2 stingtargstruct_getorigins();
      var_2 stingtargstruct_getinreticle();
      if(!var_2 stingtargstruct_isinreticle()) {
        resetmissilelauncherlocking();
        continue;
      }

      var_2 stingtargstruct_getinlos();
      if(!softsighttest(var_2)) {
        continue;
      }

      var_7 = gettime() - self.var_10FA6;
      if(scripts\mp\utility::_hasperk("specialty_fasterlockon")) {
        if(var_7 < 375) {
          continue;
        }
      } else if(var_7 < 750) {
        continue;
      }

      self notify("stop_javelin_locking_feedback");
      thread func_B069();
      var_8 = undefined;
      stinger_finalizelock(var_2);
      self.var_10FA9 = 2;
    }

    if(self.var_10FA9 == 2) {
      if(!isDefined(self.var_10FAA)) {
        resetmissilelauncherlocking();
        continue;
      }

      var_2 = stingtargstruct_create(self, self.var_10FAA);
      var_2 stingtargstruct_getoffsets();
      var_2 stingtargstruct_getorigins();
      var_2 stingtargstruct_getinreticle();
      var_2 stingtargstruct_getinlos();
      if(!softsighttest(var_2)) {
        continue;
      } else {
        stinger_finalizelock(var_2);
      }

      if(!var_2 stingtargstruct_isinreticle()) {
        resetmissilelauncherlocking();
        continue;
      }
    }
  }
}

stinger_finalizelock(var_0) {
  var_1 = undefined;
  if(isDefined(var_0.inlosid)) {
    var_1 = var_0.offsets[var_0.inlosid];
    var_1 = (var_1[1], -1 * var_1[0], var_1[2]);
  } else {
    var_1 = (0, 0, 0);
  }

  self _meth_8402(self.var_10FAA, var_1);
}

func_17D0(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0;
  if(isDefined(var_0.triggerportableradarping) && !scripts\mp\utility::func_9EF0(var_0)) {
    var_1 = var_0.triggerportableradarping;
  }

  var_1 setclientomnvar("ui_killstreak_missile_warn", 1);
}

func_E12E(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0;
  if(isDefined(var_0.triggerportableradarping) && !scripts\mp\utility::func_9EF0(var_0)) {
    var_1 = var_0.triggerportableradarping;
  }

  var_1 setclientomnvar("ui_killstreak_missile_warn", 0);
}

stingtargstruct_create(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.player = var_0;
  var_2.target = var_1;
  var_2.offsets = [];
  var_2.origins = [];
  var_2.inreticledistssqr = [];
  var_2.inreticlesortedids = [];
  var_2.inlosid = undefined;
  var_2.useoldlosverification = 1;
  return var_2;
}

stingtargstruct_getoffsets() {
  self.offsets = [];
  if(scripts\mp\utility::isjackal(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 125);
    self.offsets[self.offsets.size] = (0, 250, 125);
    self.offsets[self.offsets.size] = (0, -425, 125);
    self.offsets[self.offsets.size] = (-250, -215, 140);
    self.offsets[self.offsets.size] = (250, -215, 140);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility::func_9F8C(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 30);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility::ismicroturret(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 15);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility::isturret(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 42);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility::func_9F22(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 70);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
    return;
  }

  self.offsets[self.offsets.size] = (0, 0, 0);
}

stingtargstruct_getorigins() {
  var_0 = self.target.origin;
  var_1 = self.target.angles;
  var_2 = anglesToForward(var_1);
  var_3 = anglestoright(var_1);
  var_4 = anglestoup(var_1);
  for(var_5 = 0; var_5 < self.offsets.size; var_5++) {
    var_6 = self.offsets[var_5];
    self.origins[var_5] = var_0 + var_3 * var_6[0] + var_2 * var_6[1] + var_4 * var_6[2];
  }
}

stingtargstruct_getinreticle() {
  foreach(var_1 in self.origins) {
    for(var_2 = 0; var_2 < self.origins.size; var_2++) {
      var_3 = self.player _meth_840B(self.origins[var_2], 65);
      if(isDefined(var_3)) {
        var_4 = length2dsquared(var_3);
        if(var_4 <= 7225) {
          self.inreticlesortedids[self.inreticlesortedids.size] = var_2;
          self.inreticledistssqr[var_2] = var_4;
        }
      }
    }
  }

  if(self.inreticlesortedids.size > 1) {
    for(var_2 = 0; var_2 < self.inreticlesortedids.size; var_2++) {
      for(var_6 = var_2 + 1; var_6 < self.inreticlesortedids.size; var_6++) {
        var_7 = self.inreticlesortedids[var_2];
        var_8 = self.inreticlesortedids[var_6];
        var_9 = self.inreticledistssqr[var_7];
        var_0A = self.inreticledistssqr[var_8];
        if(var_0A < var_9) {
          var_0B = var_7;
          self.inreticlesortedids[var_2] = var_8;
          self.inreticlesortedids[var_6] = var_0B;
        }
      }
    }
  }
}

stingtargstruct_getinlos() {
  var_0 = self.player getEye();
  var_1 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);
  var_2 = [self.player, self.target];
  var_3 = self.target getlinkedchildren();
  if(isDefined(var_3) && var_3.size > 0) {
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  if(!self.useoldlosverification) {
    for(var_4 = 0; var_4 < self.inreticlesortedids.size; var_4++) {
      var_5 = self.inreticlesortedids[var_4];
      var_6 = self.origins[var_5];
      var_7 = physics_raycast(var_0, var_6, var_1, var_2, 0, "physicsquery_closest", 1);
      if(!isDefined(var_7) || var_7.size == 0) {
        self.inlosid = var_5;
        return;
      }
    }

    return;
  }

  var_8 = scripts\common\trace::ray_trace(var_0, self.origins[0], var_2, var_1, 0);
  if(var_8["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  var_9 = self.target getpointinbounds(1, 0, 0);
  var_8 = scripts\common\trace::ray_trace(var_0, var_9, var_2, var_1, 0);
  if(var_8["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  var_0A = self.target getpointinbounds(-1, 0, 0);
  var_8 = scripts\common\trace::ray_trace(var_0, var_0A, var_2, var_1, 0);
  if(var_8["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }
}

stingtargstruct_isinreticle() {
  return self.inreticlesortedids.size > 0;
}

stingtargstruct_isinlos() {
  return isDefined(self.inlosid);
}