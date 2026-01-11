/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2803.gsc
***************************************/

func_98D5() {
  self.func_10FA9 = undefined;
  self.func_10FAA = undefined;
  self.func_10FA6 = undefined;
  self.func_10FA7 = undefined;
  thread func_E273();
  level.func_10FAB = [];
}

resetmissilelauncherlocking() {
  if(!isDefined(self.func_10FAE)) {
    return;
  }
  self.func_10FAE = undefined;
  self notify("stop_javelin_locking_feedback");
  self notify("stop_javelin_locked_feedback");
  self notify("stinger_lock_lost");
  self _meth_8403();
  self stopolcalsound("maaws_reticle_tracking");
  self stopolcalsound("maaws_reticle_locked");
  func_E12E(self.func_10FAA);
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
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.func_10FAA) && self.func_10FAA == level.chopper.gunner) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    if(isDefined(level.ac130player) && isDefined(self.func_10FAA) && self.func_10FAA == level.ac130.planemodel) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    self playlocalsound("maaws_reticle_tracking");
    self playrumbleonentity("ac130_25mm_fire");
    wait 0.6;
  }
}

func_B069() {
  self endon("stop_javelin_locked_feedback");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.func_10FAA) && self.func_10FAA == level.chopper.gunner) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    if(isDefined(level.ac130player) && isDefined(self.func_10FAA) && self.func_10FAA == level.ac130.planemodel) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    self playlocalsound("maaws_reticle_locked");
    self playrumbleonentity("ac130_25mm_fire");
    wait 0.25;
  }
}

softsighttest(var_00) {
  var_01 = 500;

  if(var_00 stingtargstruct_isinlos()) {
    self.func_10FA7 = 0;
    return 1;
  }

  if(self.func_10FA7 == 0) {
    self.func_10FA7 = gettime();
  }

  var_02 = gettime() - self.func_10FA7;

  if(var_02 >= var_01) {
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
    wait 0.05;

    if(self playerads() < 0.95) {
      resetmissilelauncherlocking();
      continue;
    }

    var_00 = scripts\mp\utility\game::getweaponbasedsmokegrenadecount(self getcurrentweapon());

    if(var_00 != "iw7_lockon_mp") {
      resetmissilelauncherlocking();
      continue;
    }

    self.func_10FAE = 1;

    if(!isDefined(self.func_10FA9)) {
      self.func_10FA9 = 0;
    }

    if(self.func_10FA9 == 0) {
      var_01 = scripts\mp\weapons::func_AF2B(0);

      if(var_1.size == 0) {
        continue;
      }
      var_01 = sortbydistance(var_01, self.origin);
      var_02 = undefined;
      var_03 = 0;

      foreach(var_05 in var_01) {
        if(!isDefined(var_05)) {
          continue;
        }
        var_02 = stingtargstruct_create(self, var_05);
        var_02 stingtargstruct_getoffsets();
        var_02 stingtargstruct_getorigins();
        var_02 stingtargstruct_getinreticle();

        if(var_02 stingtargstruct_isinreticle()) {
          var_03 = 1;
          break;
        }
      }

      if(!var_03) {
        continue;
      }
      var_02 stingtargstruct_getinlos();

      if(!var_02 stingtargstruct_isinlos()) {
        continue;
      }
      self.func_10FAA = var_2.target;
      self.func_10FA6 = gettime();
      self.func_10FA9 = 1;
      self.func_10FA7 = 0;
      func_17D0(self.func_10FAA);
      thread func_B06A();
    }

    if(self.func_10FA9 == 1) {
      if(!isDefined(self.func_10FAA)) {
        resetmissilelauncherlocking();
        continue;
      }

      var_02 = stingtargstruct_create(self, self.func_10FAA);
      var_02 stingtargstruct_getoffsets();
      var_02 stingtargstruct_getorigins();
      var_02 stingtargstruct_getinreticle();

      if(!var_02 stingtargstruct_isinreticle()) {
        resetmissilelauncherlocking();
        continue;
      }

      var_02 stingtargstruct_getinlos();

      if(!softsighttest(var_02)) {
        continue;
      }
      var_07 = gettime() - self.func_10FA6;

      if(scripts\mp\utility\game::_hasperk("specialty_fasterlockon")) {
        if(var_07 < 375.0) {
          continue;
        }
      } else if(var_07 < 750) {
        continue;
      }
      self notify("stop_javelin_locking_feedback");
      thread func_B069();
      var_08 = undefined;
      stinger_finalizelock(var_02);
      self.func_10FA9 = 2;
    }

    if(self.func_10FA9 == 2) {
      if(!isDefined(self.func_10FAA)) {
        resetmissilelauncherlocking();
        continue;
      }

      var_02 = stingtargstruct_create(self, self.func_10FAA);
      var_02 stingtargstruct_getoffsets();
      var_02 stingtargstruct_getorigins();
      var_02 stingtargstruct_getinreticle();
      var_02 stingtargstruct_getinlos();

      if(!softsighttest(var_02)) {
        continue;
      } else {
        stinger_finalizelock(var_02);
      }

      if(!var_02 stingtargstruct_isinreticle()) {
        resetmissilelauncherlocking();
        continue;
      }
    }
  }
}

stinger_finalizelock(var_00) {
  var_01 = undefined;

  if(isDefined(var_0.inlosid)) {
    var_01 = var_0.offsets[var_0.inlosid];
    var_01 = (var_1[1], -1 * var_1[0], var_1[2]);
  } else
    var_01 = (0, 0, 0);

  self _meth_8402(self.func_10FAA, var_01);
}

func_17D0(var_00) {
  if(!isDefined(var_00)) {
    return;
  }
  var_01 = var_00;

  if(isDefined(var_0.owner) && !scripts\mp\utility\game::func_9EF0(var_00)) {
    var_01 = var_0.owner;
  }

  var_01 setclientomnvar("ui_killstreak_missile_warn", 1);
}

func_E12E(var_00) {
  if(!isDefined(var_00)) {
    return;
  }
  var_01 = var_00;

  if(isDefined(var_0.owner) && !scripts\mp\utility\game::func_9EF0(var_00)) {
    var_01 = var_0.owner;
  }

  var_01 setclientomnvar("ui_killstreak_missile_warn", 0);
}

stingtargstruct_create(var_00, var_01) {
  var_02 = spawnStruct();
  var_2.player = var_00;
  var_2.target = var_01;
  var_2.offsets = [];
  var_2.origins = [];
  var_2.inreticledistssqr = [];
  var_2.inreticlesortedids = [];
  var_2.inlosid = undefined;
  var_2.useoldlosverification = 1;
  return var_02;
}

stingtargstruct_getoffsets() {
  self.offsets = [];

  if(scripts\mp\utility\game::isjackal(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 125);
    self.offsets[self.offsets.size] = (0, 250, 125);
    self.offsets[self.offsets.size] = (0, -425, 125);
    self.offsets[self.offsets.size] = (-250, -215, 140);
    self.offsets[self.offsets.size] = (250, -215, 140);
    self.useoldlosverification = 0;
  } else if(scripts\mp\utility\game::func_9F8C(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 30);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
  } else if(scripts\mp\utility\game::ismicroturret(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 15);
    self.useoldlosverification = 0;
  } else if(scripts\mp\utility\game::isturret(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 42);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
  } else if(scripts\mp\utility\game::func_9F22(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 70);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
  } else
    self.offsets[self.offsets.size] = (0, 0, 0);
}

stingtargstruct_getorigins() {
  var_00 = self.target.origin;
  var_01 = self.target.angles;
  var_02 = anglesToForward(var_01);
  var_03 = anglestoright(var_01);
  var_04 = anglestoup(var_01);

  for(var_05 = 0; var_05 < self.offsets.size; var_5++) {
    var_06 = self.offsets[var_05];
    self.origins[var_05] = var_00 + var_03 * var_6[0] + var_02 * var_6[1] + var_04 * var_6[2];
  }
}

stingtargstruct_getinreticle() {
  foreach(var_05, var_01 in self.origins) {
    for(var_02 = 0; var_02 < self.origins.size; var_2++) {
      var_03 = self.player _meth_840B(self.origins[var_02], 65);

      if(isDefined(var_03)) {
        var_04 = length2dsquared(var_03);

        if(var_04 <= 7225) {
          self.inreticlesortedids[self.inreticlesortedids.size] = var_02;
          self.inreticledistssqr[var_02] = var_04;
        }
      }
    }
  }

  if(self.inreticlesortedids.size > 1) {
    for(var_02 = 0; var_02 < self.inreticlesortedids.size; var_2++) {
      for(var_06 = var_02 + 1; var_06 < self.inreticlesortedids.size; var_6++) {
        var_07 = self.inreticlesortedids[var_02];
        var_08 = self.inreticlesortedids[var_06];
        var_09 = self.inreticledistssqr[var_07];
        var_10 = self.inreticledistssqr[var_08];

        if(var_10 < var_09) {
          var_11 = var_07;
          self.inreticlesortedids[var_02] = var_08;
          self.inreticlesortedids[var_06] = var_11;
        }
      }
    }
  }
}

stingtargstruct_getinlos() {
  var_00 = self.player getEye();
  var_01 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);
  var_02 = [self.player, self.target];
  var_03 = self.target getlinkedchildren();

  if(isDefined(var_03) && var_3.size > 0) {
    var_02 = scripts\engine\utility::array_combine(var_02, var_03);
  }

  if(!self.useoldlosverification) {
    for(var_04 = 0; var_04 < self.inreticlesortedids.size; var_4++) {
      var_05 = self.inreticlesortedids[var_04];
      var_06 = self.origins[var_05];
      var_07 = physics_raycast(var_00, var_06, var_01, var_02, 0, "physicsquery_closest", 1);

      if(!isDefined(var_07) || var_7.size == 0) {
        self.inlosid = var_05;
        return;
      }
    }
  } else {
    var_08 = scripts\engine\trace::ray_trace(var_00, self.origins[0], var_02, var_01, 0);

    if(var_8["fraction"] == 1) {
      self.inlosid = 0;
      return;
    }

    var_09 = self.target getpointinbounds(1, 0, 0);
    var_08 = scripts\engine\trace::ray_trace(var_00, var_09, var_02, var_01, 0);

    if(var_8["fraction"] == 1) {
      self.inlosid = 0;
      return;
    }

    var_10 = self.target getpointinbounds(-1, 0, 0);
    var_08 = scripts\engine\trace::ray_trace(var_00, var_10, var_02, var_01, 0);

    if(var_8["fraction"] == 1) {
      self.inlosid = 0;
      return;
    }
  }
}

stingtargstruct_isinreticle() {
  return self.inreticlesortedids.size > 0;
}

stingtargstruct_isinlos() {
  return isDefined(self.inlosid);
}